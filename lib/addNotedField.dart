import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coma_system_detect/Auth/login.dart';
import 'package:coma_system_detect/DialogBox/errorDialog.dart';
import 'package:coma_system_detect/DialogBox/loadingDialog.dart';
import 'package:coma_system_detect/homePage.dart';
import 'package:coma_system_detect/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/customTextField.dart';

class addNotedFileds extends StatefulWidget {
  @override
  _addNotedFileds createState() => _addNotedFileds();
}

RegistrarRole _role = RegistrarRole.male;

enum RegistrarRole { female, male }

class _addNotedFileds extends State<addNotedFileds> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _userAge = TextEditingController();

  final TextEditingController _ConsitionTextEditingController =
      TextEditingController();

  final TextEditingController _NotesTextEditingController =
      TextEditingController();

  final TextEditingController _familyNameTextEditingController =
      TextEditingController();

  final TextEditingController _familyPHoneNumber = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0XFFCDCDCD),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    "Patient Information",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 25),
                  ),
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  // CustomTextField(
                  //   controller: _cPasswordTextEditingController,
                  //   data: Icons.lock,
                  //   hintText: "Confirm Password",
                  //   isObsecure: true,
                  // ),
                  CustomTextField(
                    controller: _userAge,
                    data: Icons.face,
                    hintText: "Age",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _ConsitionTextEditingController,
                    data: Icons.sync_problem,
                    hintText: "Condition",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _NotesTextEditingController,
                    data: Icons.note_add,
                    hintText: "Notes",
                    isObsecure: false,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio(
                            value: RegistrarRole.male,
                            groupValue: _role,
                            onChanged: (RegistrarRole? value) {
                              setState(() {
                                _role = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: const Text('Female'),
                          leading: Radio(
                            value: RegistrarRole.female,
                            groupValue: _role,
                            onChanged: (RegistrarRole? value) {
                              setState(() {
                                _role = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Family Information",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 25),
                  ),
                  CustomTextField(
                    controller: _familyNameTextEditingController,
                    data: Icons.person_add,
                    hintText: "Family memeber name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _familyPHoneNumber,
                    data: Icons.phone,
                    hintText: "Family memeber phone number",
                    isObsecure: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (c) => login());
                Navigator.push(context, route);
              },
              icon: const Icon(Icons.account_box, color: Colors.blue),
              label: const Text("Login?",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadAndSaveImage() async {
    _emailTextEditingController.text.isNotEmpty &&
            _passwordTextEditingController.text.isNotEmpty &&
            _nameTextEditingController.text.isNotEmpty &&
            _userAge.text.isNotEmpty &&
            _ConsitionTextEditingController.text.isNotEmpty &&
            _NotesTextEditingController.text.isNotEmpty &&
            _familyNameTextEditingController.text.isNotEmpty &&
            _familyPHoneNumber.text.isNotEmpty
        ? uploadToStorage()
        : displayDialog("Plaese Fill up the Patient Information");
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Saving Data, Please Wait...",
          );
        });
    _registring();
  }

  var currentUser;
  void _registring() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
      saveUserInfo(currentUser);
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) => ErrorAlertDialog(
          message: error.message.toString(),
        ),
      );
    });
  }

  Future saveUserInfo(User? currentUser) async {
    var currentTime = DateTime.now();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .set({
      "uid": currentUser.uid.toString(),
      "email": _emailTextEditingController.text.trim(),
      "name": _nameTextEditingController.text.trim(),
      "age": _userAge.text.trim(),
      "condition": _ConsitionTextEditingController.text.trim(),
      "notes": _NotesTextEditingController.text.trim(),
      "role": _role.name,
      "familyMemberName": _familyNameTextEditingController.text.trim(),
      "familyMemberPhone": _familyPHoneNumber.text.trim(),
      "RegistredTime": DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
    });

    sharedPreferences?.setString(
        "emailShared", _emailTextEditingController.text.trim());

    sharedPreferences?.setString("uid", currentUser.toString());

    sharedPreferences?.setString(
        "name", _nameTextEditingController.text.toString());

    Navigator.pop(context);
    Route route = MaterialPageRoute(builder: (context) => const homePage());
    Navigator.pushReplacement(context, route);
  }
}
