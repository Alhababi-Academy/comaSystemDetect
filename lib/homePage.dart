import 'dart:async';

import 'package:coma_system_detect/Dashboard.dart';
import 'package:coma_system_detect/about.dart';
import 'package:coma_system_detect/addNotes.dart';
import 'package:coma_system_detect/sendingData.dart';
import 'package:coma_system_detect/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth/login.dart';

class homePage extends StatefulWidget {
  const homePage({Key? Key}) : super(key: Key);
  _homePage createState() => _homePage();
}

class _homePage extends State<homePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages = [
    Dashboard(),
    sendingData(),
    addNotes(),
    editProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(sharedPreferences!.getString("name").toString()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((result) {
                  Route route = MaterialPageRoute(builder: (c) => login());
                  Navigator.pushReplacement(context, route);
                });
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Material(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Live Checking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
