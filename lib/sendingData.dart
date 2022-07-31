import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coma_system_detect/DialogBox/errorDialog.dart';
import 'package:coma_system_detect/DialogBox/loadingDialog.dart';
import 'package:coma_system_detect/addNotedField.dart';
import 'package:coma_system_detect/widgets/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/iconic_icons.dart';

class sendingData extends StatefulWidget {
  @override
  _sendingData createState() => _sendingData();
}

class _sendingData extends State<sendingData> {
  User? user = FirebaseAuth.instance.currentUser;
  Color color1 = const Color.fromARGB(128, 43, 16, 215);
  Color color2 = const Color.fromARGB(96, 1, 26, 134);
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _DoctorName = TextEditingController();

  final TextEditingController _Note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    String currentUser = user!.uid;

    return Scaffold(
      bottomNavigationBar: Material(
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("data")
                .where("temp", isNotEqualTo: null)
                .where("uid", isEqualTo: currentUser)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        var gettingDate = snapshot.data!.docs[index]['Date'];
                        var asdf = gettingDate.toDate().toString();
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 19, bottom: 8, left: 19),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                                right: 8, left: 8, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Motion Detected",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesome5.temperature_high,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot
                                                      .data!.docs[index]['temp']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Iconic.cloud,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data!
                                                      .docs[index]['humid']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 21.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Text(
                                            asdf.replaceRange(10, 23, ''),
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesome5.temperature_high,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data!
                                                      .docs[index]['heartBeat']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     const Icon(
                                          //       Iconic.cloud,
                                          //       color: Colors.red,
                                          //       size: 25,
                                          //     ),
                                          //     const SizedBox(
                                          //       width: 4,
                                          //     ),
                                          //     Expanded(
                                          //       child: Text(
                                          //         snapshot.data!
                                          //             .docs[index]['humid']
                                          //             .toString(),
                                          //         style: const TextStyle(
                                          //             color: Colors.black,
                                          //             fontSize: 21.0),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget displayAdminUploadFormScreen() {
    String currentUser = user!.uid;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          "Adding New Note",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 12.0)),
          ListTile(
            leading: const Icon(
              Icons.wrap_text,
              color: Colors.blue,
            ),
            title: SizedBox(
              width: 250.0,
              child: TextField(
                style: const TextStyle(color: Colors.indigo),
                controller: _DoctorName,
                decoration: const InputDecoration(
                  hintText: "Doctor Name",
                  hintStyle: TextStyle(color: Colors.indigo),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.blue,
            ),
            title: SizedBox(
              width: 250.0,
              child: TextField(
                style: const TextStyle(color: Colors.indigo),
                controller: _Note,
                decoration: const InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(color: Colors.indigo),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                uploadAndSaveImage(currentUser);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add Service",
                  style: TextStyle(fontSize: 23.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadAndSaveImage(String currentUser) async {
    _DoctorName.text.isNotEmpty && _Note.text.isNotEmpty
        ? uploadToStorage(currentUser)
        : displayDialog("Fill up the Form...");
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

  Future uploadToStorage(currentUser) async {
    Future.delayed(const Duration(seconds: 3));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Note was Added"),
    ));

    saveItemInfo(currentUser);
  }

  deleteing(String serviceItemID) async {
    String currentUser = user!.uid;
    print("This is currentUser $currentUser and $serviceItemID");
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingAlertDialog(
            message: "Deleting Note",
          );
        });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection("services")
        .doc(serviceItemID)
        .delete()
        .then((value) {
      Navigator.pop(context);
    });
  }

  saveItemInfo(currentUser) {
    final itemsRef = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection("services");
    itemsRef.add({
      "doctorName": _DoctorName.text.trim(),
      "note": _Note.text.trim(),
      "date": DateTime.now(),
    }).then((value) {
      setState(() {
        _DoctorName.clear();
        _Note.clear();
      });
    });
    Navigator.pop(context);
  }
}
