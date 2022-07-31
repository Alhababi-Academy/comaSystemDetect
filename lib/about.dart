import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coma_system_detect/DialogBox/errorDialog.dart';
import 'package:coma_system_detect/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'widgets/customTextField.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfile createState() => _editProfile();
}

class _editProfile extends State<editProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _userAge = TextEditingController();

  final TextEditingController _ConsitionTextEditingController =
      TextEditingController();

  final TextEditingController _NotesTextEditingController =
      TextEditingController();

  final TextEditingController _familyNameTextEditingController =
      TextEditingController();

  final TextEditingController _familyPHoneNumber = TextEditingController();
  // int? servicePrice;

  @override
  void initState() {
    gettingData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Getting Data
  Future gettingData() async {
    String uid = user!.uid;

    var result =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (result != null) {
      _nameTextEditingController.text = result.data()!['name'];
      _emailTextEditingController.text = result.data()!['email'];
      _userAge.text = result.data()!['age'];
      _ConsitionTextEditingController.text = result.data()!['condition'];
      _NotesTextEditingController.text = result.data()!['notes'];
      _familyNameTextEditingController.text =
          result.data()!['familyMemberName'];
      _familyPHoneNumber.text = result.data()!['familyMemberPhone'];
    } else {
      print("Sorry There is no Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: const Color(0XFFCDCDCD),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                  uploadToStorage();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Update Data",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return const LoadingAlertDialog(
            message: "Updating Data...",
          );
        });
    updatingData();
  }

  Future updatingData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "name": _nameTextEditingController.text.trim(),
      "email": _emailTextEditingController.text.trim(),
      "age": _userAge.text.trim(),
      "condition": _ConsitionTextEditingController.text.trim(),
      "notes": _NotesTextEditingController.text.trim(),
      "familyMemberName": _familyNameTextEditingController.text.trim(),
      "familyMemberPhone": _familyPHoneNumber.text.trim()
    }).then((value) {
      Navigator.pop(context);
    });
  }
}
