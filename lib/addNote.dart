// import 'dart:math';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
//
// class addnote extends StatefulWidget {
//   @override
//   addnoteState createState() => addnoteState();
// }
//
// class addnoteState extends State<addnote> {
//   TextEditingController second = TextEditingController();
//
//   TextEditingController third = TextEditingController();
//
//   final fb = FirebaseDatabase.instance;
//   @override
//   Widget build(BuildContext context) {
//     var rng = Random();
//     var k = rng.nextInt(10000);
//
//     final ref = fb.ref().child('todos/$k');
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Todos"),
//         backgroundColor: Colors.indigo[900],
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all()),
//               child: TextField(
//                 controller: second,
//                 decoration: const InputDecoration(
//                   hintText: 'title',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border.all()),
//               child: TextField(
//                 controller: third,
//                 decoration: InputDecoration(
//                   hintText: 'sub title',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             MaterialButton(
//               color: Colors.indigo[900],
//               onPressed: () {
//                 ref.set({
//                   "title": second.text,
//                   "subtitle": third.text,
//                 }).asStream();
//                 Navigator.pushReplacement(
//                     context, MaterialPageRoute(builder: (_) => Home()));
//               },
//               child: const Text(
//                 "save",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }