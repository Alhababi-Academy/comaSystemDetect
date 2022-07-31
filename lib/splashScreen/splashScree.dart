// import 'dart:async';

// import 'package:flutter/material.dart';

// class splashScreen extends StatefulWidget {
//   const splashScreen({Key? key}) : super(key: key);

//   _splashScreen createState() => _splashScreen();
// }

// class _splashScreen extends State<splashScreen> {
//   displaySplash() {
//     Timer(const Duration(seconds: 5), () async {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Material(
//       child: Text("Hello Wolrd"),
//     );
//   }
// }

import 'dart:async';

import 'package:coma_system_detect/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/registrationPage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  _splashScreen createState() => _splashScreen();
}

class _splashScreen extends State<splashScreen> {
  displaySplash() async {
    Timer(const Duration(seconds: 7), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        Route route = MaterialPageRoute(builder: (context) => const homePage());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (context) => Register());
        Navigator.pushReplacement(context, route);
      }
    });
    // var gettingData = await FirebaseFirestore.instance
    //     .collection("users")
    //     .get()
    //     .then((value) {
    //   // print("This is the value ${value.docs}");
    //   print("This is value ${value.docs.isEmpty}");
    //   if (value.docs.isEmpty) {
    //     Route route = MaterialPageRoute(builder: (context) => Register());
    //     Navigator.pushReplacement(context, route);
    //   } else {
    //     Route route = MaterialPageRoute(builder: (context) => homePage());
    //     Navigator.pushReplacement(context, route);
    //   }
    // });
  }

  @override
  void initState() {
    displaySplash();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Coma System",
              style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              "images/1.png",
              width: 250,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "this systems is used to monitor patient in realtime, this system will detect Temperature, Humidity, patient heartbeat and also patient montion. ",
              style: TextStyle(height: 1.4),
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              maxLines: 6,
            ),

            // SizedBox(
            //   width: MediaQuery.of(context).size.width - 100,
            //   child: Expanded(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text(
            //           "this systems is usesd to monitor patient in realtime, this system will detect Temperature, Humidity, patient heartbeat and also patient montion. ",
            //           style: TextStyle(height: 1.4),
            //           softWrap: true,
            //           textAlign: TextAlign.center,
            //           overflow: TextOverflow.clip,
            //           maxLines: 6,
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}
