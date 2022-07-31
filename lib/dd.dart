// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'CircleProgress.dart';
// import 'main.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard>
//     with SingleTickerProviderStateMixin {
//   final databaseReference = FirebaseDatabase.instance.ref();

//   AnimationController? progressController;
//   Animation? tempAnimation;
//   Animation? humidityAnimation;
//   Animation? heartBeatAnimatino;
//   var temp;
//   var humid;
//   var heartbeat;

//   @override
//   void initState() {
//     super.initState();

//     databaseReference.once().then((result) {
//       for (var element in result.snapshot.children) {
//         var temp = element.child("Temperature").value;
//         int gettingTempInInt = int.tryParse(temp.toString())!.toInt();
//         print("This is the Temp $gettingTempInInt");

//         var Hum = element.child("Humidity").value;
//         int gettingHumInInt = int.tryParse(Hum.toString())!.toInt();

//         var heartBeat = element.child("heartBeat").value;
//         int GettingheartBeat = int.tryParse(heartBeat.toString())!.toInt();
//         print("This is the heartBaeet $gettingHumInInt");
//         // _DashboardInit(gettingTempInInt, gettingHumInInt, GettingheartBeat);
//       }
//     });
//   }

//   _DashboardInit(temp, humid, heartbeat) {
//     progressController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 5000)); //5s

//     tempAnimation = Tween(begin: -50, end: temp).animate(progressController!)
//       ..addListener(() {
//         setState(() {
//           temp;
//         });
//       });

//     humidityAnimation = Tween(begin: 0, end: humid).animate(progressController!)
//       ..addListener(() {
//         setState(() {
//           humid;
//         });
//       });

//     setState(() {
//       humidityAnimation;
//     });
//     heartBeatAnimatino =
//         Tween(begin: 0, end: heartbeat).animate(progressController!)
//           ..addListener(() {
//             setState(() {});
//           });

//     progressController!.forward();
//   }

//   ddd() {
//     humidityAnimation?.value.toInt();
//     setState(() {
//       humidityAnimation?.value.toInt();
//     });

//     return humidityAnimation?.value.toInt();
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       tempAnimation?.value.toInt();
//     });
//     return Material(
//       // child: Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     children: <Widget>[
//       //       CustomPaint(
//       //         foregroundPainter:
//       //             CircleProgress(tempAnimation!.value.toInt(), true, false),
//       //         child: Container(
//       //           width: 200,
//       //           height: 200,
//       //           child: Center(
//       //             child: Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: <Widget>[
//       //                 const Text('Temperature'),
//       //                 Text(
//       //                   '${tempAnimation!.value.toInt()}',
//       //                   style: const TextStyle(
//       //                       fontSize: 50, fontWeight: FontWeight.bold),
//       //                 ),
//       //                 const Text(
//       //                   '°C',
//       //                   style: const TextStyle(
//       //                       fontSize: 20, fontWeight: FontWeight.bold),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //       CustomPaint(
//       //         foregroundPainter:
//       //             CircleProgress(humidityAnimation?.value, false, false),
//       //         child: Container(
//       //           width: 200,
//       //           height: 200,
//       //           child: Center(
//       //             child: Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: <Widget>[
//       //                 const Text('Humidity'),
//       //                 Text(
//       //                   '${humidityAnimation?.value.toInt()}',
//       //                   style: const TextStyle(
//       //                       fontSize: 50, fontWeight: FontWeight.bold),
//       //                 ),
//       //                 const Text(
//       //                   '%',
//       //                   style: TextStyle(
//       //                       fontSize: 20, fontWeight: FontWeight.bold),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //       CustomPaint(
//       //         foregroundPainter:
//       //             CircleProgress(heartBeatAnimatino?.value, false, true),
//       //         child: Container(
//       //           width: 200,
//       //           height: 200,
//       //           child: Center(
//       //             child: Column(
//       //               mainAxisAlignment: MainAxisAlignment.center,
//       //               children: <Widget>[
//       //                 const Text('Heart Beat'),
//       //                 Text(
//       //                   '${heartBeatAnimatino?.value.toInt()}',
//       //                   style: const TextStyle(
//       //                       fontSize: 50, fontWeight: FontWeight.bold),
//       //                 ),
//       //                 const Text(
//       //                   'BPM',
//       //                   style: TextStyle(
//       //                       fontSize: 20, fontWeight: FontWeight.bold),
//       //                 ),
//       //               ],
//       //             ),
//       //           ),
//       //         ),
//       //       )
//       //     ],
//       //   ),
//       // ),

//       child: StreamBuilder(
//         stream: databaseReference.onValue,
//         builder: (context, snapshot) {
//           // List<Message> messageList = [];
//           if (snapshot.hasData &&
//               snapshot.data != null &&
//               (snapshot.data! as DatabaseEvent).snapshot.value != null) {
//             final myMessages = Map<dynamic, dynamic>.from(
//                 (snapshot.data! as DatabaseEvent).snapshot.value
//                     as Map<dynamic, dynamic>); //typecasting
//             myMessages.forEach((key, value) {
//               final currentMessage = Map<String, dynamic>.from(value);
//               currentMessage.forEach((key, value) {
//                 // var listlist = currentMessage.values.toList();
//                 // print(listlist[1]);
//                 var currentTemp = currentMessage['Temperature'];
//                 temp = currentTemp;
//                 print("This isthe ucrrent tmep $temp");
//               });
//             }); //created a class called message and added all messages in a List of class message
//             return ListView.builder(
//               reverse: true,
//               itemCount: myMessages.length,
//               itemBuilder: (context, index) {
//                 myMessages.entries.elementAt(0);
//                 for (var data in myMessages.values) {
//                   print("This is data $data");
//                 }
//                 myMessages.forEach((key, value) {});
//                 print(myMessages.entries.toList()); // return ChattingDesign(
//                 //   message: messageList[index],
//                 //   dbpathToMsgChnl:
//                 //       'TextChannels/${widget.channels['ChannelName']}/Messages',
//                 //   showName: shouldShowName(
//                 //     index,
//                 //     messageList.length - 1,
//                 //     messageList,
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     CustomPaint(
//                       foregroundPainter: CircleProgress(
//                           tempAnimation!.value.toInt(), true, false),
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               const Text('Temperature'),
//                               Text(
//                                 '${tempAnimation!.value.toInt()}',
//                                 style: const TextStyle(
//                                     fontSize: 50, fontWeight: FontWeight.bold),
//                               ),
//                               const Text(
//                                 '°C',
//                                 style: const TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     CustomPaint(
//                       foregroundPainter: CircleProgress(
//                           humidityAnimation?.value, false, false),
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               const Text('Humidity'),
//                               Text(
//                                 '${humidityAnimation?.value.toInt()}',
//                                 style: const TextStyle(
//                                     fontSize: 50, fontWeight: FontWeight.bold),
//                               ),
//                               const Text(
//                                 '%',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     CustomPaint(
//                       foregroundPainter: CircleProgress(
//                           heartBeatAnimatino?.value, false, true),
//                       child: Container(
//                         width: 200,
//                         height: 200,
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               const Text('Heart Beat'),
//                               Text(
//                                 '${heartBeatAnimatino?.value.toInt()}',
//                                 style: const TextStyle(
//                                     fontSize: 50, fontWeight: FontWeight.bold),
//                               ),
//                               const Text(
//                                 'BPM',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             );
//           } else {
//             return Center(
//               child: Text(
//                 'Say Hi...',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 21,
//                     fontWeight: FontWeight.w400),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
