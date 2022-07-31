import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coma_system_detect/Auth/registrationPage.dart';
import 'package:coma_system_detect/DialogBox/errorDialog.dart';
import 'package:coma_system_detect/DialogBox/loadingDialog.dart';
import 'package:coma_system_detect/Widgets/customTextField.dart';
import 'package:coma_system_detect/homePage.dart';
import 'package:coma_system_detect/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

RegistrarRole _role = RegistrarRole.male;

enum RegistrarRole { female, male }

class _login extends State<login> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                    "Patient Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 25),
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
                  const SizedBox(
                    height: 15,
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
                Route route = MaterialPageRoute(builder: (c) => Register());
                Navigator.push(context, route);
              },
              icon: const Icon(Icons.account_box, color: Colors.blue),
              label: const Text("Register?",
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
            _passwordTextEditingController.text.isNotEmpty
        ? uploadToStorage()
        : displayDialog("Plaese Fill up the Form");
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
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) => ErrorAlertDialog(
          message: error.message.toString(),
        ),
      );
    });
    if (currentUser != null) {
      saveUserInfo(currentUser);
    }
  }

  Future saveUserInfo(User? currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) async {
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      sharedPreferences?.setString("emailShared", snapshot.data()!['email']);
      sharedPreferences?.setString("uid", snapshot.data()!['uid']);
      sharedPreferences?.setString("name", snapshot.data()!['name']);
    }).then((value) {
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (context) => const homePage());
      Navigator.pushReplacement(context, route);
    });
  }
}
