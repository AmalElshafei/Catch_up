// import 'package:flutter_course/loginScreen.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'Helper/ConstHelper/ConstHelper.dart';
import 'Helper/ShPreHelper/SharedPrefHelper.dart';
import 'Module/Home/Home.dart';
import 'package:flutter/foundation.dart';

import 'Module/LoginPage/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //تشيك علي اي بلاتفورم شغال
  if (kIsWeb) {
    await Firebase.initializeApp(
        //  options: DefaultFirebaseOptions.currentPlatform
        options: FirebaseOptions(
            apiKey: ConstantKeys.apiKey,
            appId: ConstantKeys.appId,
            messagingSenderId: ConstantKeys.messagingSenderId,
            projectId: ConstantKeys.projectId));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoginStatus();
  }
 getUserLoginStatus() async{
    await SharedPrefHelper.getUserLoginStatus().then((value){
      //مش نل اذا اما ترة او فولز
      if (value != null) {
        setState(() {
            isSignedIn = value;

        });
      }
    });
 }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: isSignedIn ?  HomeScreen() : const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( MyApp());
// }
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//     home: MyApp()));
// }

//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "todo app",
//       theme: ThemeData(
//         primaryColor: Colors.greenAccent[700],
//       ),
//       home: Home(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final fb = FirebaseDatabase.instance;
//   TextEditingController second = TextEditingController();
//
//   TextEditingController third = TextEditingController();
//   var l;
//   var g;
//   var k;
//   @override
//   Widget build(BuildContext context) {
//     final ref = fb.ref().child('todos');
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.indigo[900],
//         onPressed: () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => addnote(),
//             ),
//           );
//         },
//         child: const Icon(
//           Icons.add,
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text(
//           'Todos',
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.indigo[900],
//       ),
//       body: FirebaseAnimatedList(
//         query: ref,
//         shrinkWrap: true,
//         itemBuilder: (context, snapshot, animation, index) {
//           var v =
//           snapshot.value.toString(); // {subtitle: webfun, title: subscribe}
//
//           g = v.replaceAll(
//               RegExp("{|}|subtitle: |title: "), ""); // webfun, subscribe
//           g.trim();
//
//           l = g.split(','); // [webfun,  subscribe}]
//
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 k = snapshot.key;
//               });
//
//               showDialog(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   title: Container(
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: TextField(
//                       controller: second,
//                       textAlign: TextAlign.center,
//                       decoration: const InputDecoration(
//                         hintText: 'title',
//                       ),
//                     ),
//                   ),
//                   content: Container(
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: TextField(
//                       controller: third,
//                       textAlign: TextAlign.center,
//                       decoration: const InputDecoration(
//                         hintText: 'sub title',
//                       ),
//                     ),
//                   ),
//                   actions: <Widget>[
//                     MaterialButton(
//                       onPressed: () {
//                         Navigator.of(ctx).pop();
//                       },
//                       color: const Color.fromARGB(255, 0, 22, 145),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       onPressed: () async {
//                         await upd();
//                         Navigator.of(ctx).pop();
//                       },
//                       color: const Color.fromARGB(255, 0, 22, 145),
//                       child: const Text(
//                         "Update",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(
//                       color: Colors.white,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   tileColor: Colors.indigo[100],
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Color.fromARGB(255, 255, 0, 0),
//                     ),
//                     onPressed: () {
//                       ref.child(snapshot.key!).remove();
//                     },
//                   ),
//                   title: Text(
//                     l[1],
//                     // 'dd',
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     l[0],
//                     // 'dd',
//
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   upd() async {
//     DatabaseReference ref1 = FirebaseDatabase.instance.ref("todos/$k");
//
// // Only update the name, leave the age and address!
//     await ref1.update({
//       "title": second.text,
//       "subtitle": third.text,
//     });
//     second.clear();
//     third.clear();
//   }
// }
// //
// // class MyHomePage extends StatefulWidget {
// //
// //
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   late String verId;
// //   late String phone;
// //   bool codeSent = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             codeSent
// //                 ? OTPTextField(
// //               length: 6,
// //               width: MediaQuery.of(context).size.width,
// //               fieldWidth: 30,
// //               style: TextStyle(fontSize: 20),
// //               textFieldAlignment: MainAxisAlignment.spaceAround,
// //               fieldStyle: FieldStyle.underline,
// //               onCompleted: (pin) {
// //                 verifyPin(pin);
// //               },
// //             )
// //                 : IntlPhoneField(
// //               decoration: const InputDecoration(
// //                   labelText: 'Phone Number',
// //                   border: OutlineInputBorder(borderSide: BorderSide())),
// //               initialCountryCode: 'PS',
// //               onChanged: (phoneNumber) {
// //                 setState(() {
// //                   phone = phoneNumber.completeNumber;
// //                 });
// //               },
// //             ),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             TextButton(
// //                 onPressed: () {
// //                   verifyPhone();
// //                 },
// //                 child: const Text("Verify"))
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<void> verifyPhone() async {
// //     await FirebaseAuth.instance.verifyPhoneNumber(
// //         phoneNumber: phone,
// //         verificationCompleted: (PhoneAuthCredential credential) async {
// //           await FirebaseAuth.instance.signInWithCredential(credential);
// //           const snackBar = SnackBar(content: Text("Login Success"));
// //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //         },
// //         verificationFailed: (FirebaseAuthException e) {
// //           final snackBar = SnackBar(content: Text("${e.message}"));
// //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //         },
// //         codeSent: (String? verficationId, int? resendToken) {
// //           setState(() {
// //             codeSent = true;
// //             verId = verficationId!;
// //           });
// //         },
// //
// //         codeAutoRetrievalTimeout: (String verificationId) {
// //           setState(() {
// //             verId = verificationId;
// //           });
// //         },
// //         timeout: Duration(seconds: 30));
// //   }
// //
// //   Future<void> verifyPin(String pin) async {
// //     PhoneAuthCredential credential =
// //     PhoneAuthProvider.credential(verificationId: verId, smsCode: pin);
// //
// //     try {
// //       await FirebaseAuth.instance.signInWithCredential(credential);
// //       const snackBar = SnackBar(content: Text("Login Success"));
// //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //     } on FirebaseAuthException catch (e) {
// //       final snackBar = SnackBar(content: Text("${e.message}"));
// //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //     }
// //   }
// // }
// //
