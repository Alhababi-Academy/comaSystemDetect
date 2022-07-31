import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'CircleProgress.dart';
import 'main.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseDatabase.instance.ref();

  AnimationController? progressController;
  Animation? tempAnimation;
  Animation? humidityAnimation;
  Animation? heartBeatAnimatino;
  var temp;
  var humid;
  var heartbeat;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 86400), (Timer t) => checkForNewSharedLists());
    super.initState();

    // databaseReference.once().then((result) {
    //   for (var element in result.snapshot.children) {
    //     var temp = element.child("Temperature").value;
    //     int gettingTempInInt = int.tryParse(temp.toString())!.toInt();
    //     print("This is the Temp $gettingTempInInt");

    //     var Hum = element.child("Humidity").value;
    //     int gettingHumInInt = int.tryParse(Hum.toString())!.toInt();

    //     var heartBeat = element.child("heartBeat").value;
    //     int GettingheartBeat = int.tryParse(heartBeat.toString())!.toInt();
    //     print("This is the heartBaeet $gettingHumInInt");
    //     // _DashboardInit(gettingTempInInt, gettingHumInInt, GettingheartBeat);
    //   }
    // });
    setState(() {
      temp;
      humid;
      heartbeat;
    });
  }

  checkForNewSharedLists() {
    String currentUser = user!.uid;
    var time = DateTime.now().millisecondsSinceEpoch.toString();
    print("This is printed after time $temp");
    FirebaseFirestore.instance.collection("data").doc(currentUser + time).set({
      "temp": temp,
      "humid": humid,
      "heartBeat": heartbeat,
      "uid": currentUser,
      "Date": DateTime.now(),
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _DashboardInit(temp, humid, heartbeat) {
    progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000)); //5s

    tempAnimation = Tween(begin: -50, end: temp).animate(progressController!)
      ..addListener(() {
        setState(() {
          temp;
        });
      });

    humidityAnimation = Tween(begin: 0, end: humid).animate(progressController!)
      ..addListener(() {
        setState(() {
          humid;
        });
      });

    setState(() {
      humidityAnimation;
    });
    heartBeatAnimatino =
        Tween(begin: 0, end: heartbeat).animate(progressController!)
          ..addListener(() {
            setState(() {
              heartbeat;
            });
          });

    progressController!.forward();
  }

  ddd() {
    humidityAnimation?.value.toInt();
    setState(() {
      humidityAnimation?.value.toInt();
    });

    return humidityAnimation?.value.toInt();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      tempAnimation?.value.toInt();
      checkForNewSharedLists();
    });
    return Material(
      // child: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: <Widget>[
      //       CustomPaint(
      //         foregroundPainter:
      //             CircleProgress(tempAnimation!.value.toInt(), true, false),
      //         child: Container(
      //           width: 200,
      //           height: 200,
      //           child: Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 const Text('Temperature'),
      //                 Text(
      //                   '${tempAnimation!.value.toInt()}',
      //                   style: const TextStyle(
      //                       fontSize: 50, fontWeight: FontWeight.bold),
      //                 ),
      //                 const Text(
      //                   '°C',
      //                   style: const TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       CustomPaint(
      //         foregroundPainter:
      //             CircleProgress(humidityAnimation?.value, false, false),
      //         child: Container(
      //           width: 200,
      //           height: 200,
      //           child: Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 const Text('Humidity'),
      //                 Text(
      //                   '${humidityAnimation?.value.toInt()}',
      //                   style: const TextStyle(
      //                       fontSize: 50, fontWeight: FontWeight.bold),
      //                 ),
      //                 const Text(
      //                   '%',
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       CustomPaint(
      //         foregroundPainter:
      //             CircleProgress(heartBeatAnimatino?.value, false, true),
      //         child: Container(
      //           width: 200,
      //           height: 200,
      //           child: Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 const Text('Heart Beat'),
      //                 Text(
      //                   '${heartBeatAnimatino?.value.toInt()}',
      //                   style: const TextStyle(
      //                       fontSize: 50, fontWeight: FontWeight.bold),
      //                 ),
      //                 const Text(
      //                   'BPM',
      //                   style: TextStyle(
      //                       fontSize: 20, fontWeight: FontWeight.bold),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),

      child: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          // List<Message> messageList = [];
          if (snapshot.hasData &&
              snapshot.data != null &&
              (snapshot.data! as DatabaseEvent).snapshot.value != null) {
            final myMessages = Map<dynamic, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<dynamic, dynamic>); //typecasting
            myMessages.forEach((key, value) {
              final currentMessage = Map<String, dynamic>.from(value);
              currentMessage.forEach((key, value) async {
                // var listlist = currentMessage.values.toList();
                // print(listlist[1]);
                var currentTemp = currentMessage['Temperature'];
                temp = currentTemp;

                var currentHumid = currentMessage['Humidity'];
                humid = currentHumid;

                var currentHeartBeat = currentMessage['heartBeat'];
                heartbeat = currentHeartBeat;

                await _DashboardInit(currentTemp, humid, heartbeat);

                print("This isthe ucrrent tmep $temp");
              });
            }); //created a class called message and added all messages in a List of class message
            return ListView.builder(
              reverse: true,
              itemCount: myMessages.length,
              itemBuilder: (context, index) {
                myMessages.entries.elementAt(0);
                for (var data in myMessages.values) {
                  print("This is data $data");
                }
                myMessages.forEach((key, value) {});
                print(myMessages.entries.toList()); // return ChattingDesign(
                //   message: messageList[index],
                //   dbpathToMsgChnl:
                //       'TextChannels/${widget.channels['ChannelName']}/Messages',
                //   showName: shouldShowName(
                //     index,
                //     messageList.length - 1,
                //     messageList,
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomPaint(
                      foregroundPainter: CircleProgress(temp, true, false),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Temperature'),
                              Text(
                                '${temp}',
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '°C',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomPaint(
                      foregroundPainter: CircleProgress(humid, false, false),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Humidity'),
                              Text(
                                // '${humidityAnimation?.value.toInt()}',
                                '${humid}',
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomPaint(
                      foregroundPainter: CircleProgress(heartbeat, false, true),
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Heart Beat'),
                              Text(
                                // '${heartBeatAnimatino?.value.toInt()}',
                                '${heartbeat}',
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'BPM',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'Say Hi...',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w400),
              ),
            );
          }
        },
      ),
    );
  }
}
