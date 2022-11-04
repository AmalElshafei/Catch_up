import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Module/Home/Home.dart';

import '../../Helper/ConstHelper/ConstHelper.dart';
import '../../Helper/ShPreHelper/SharedPrefHelper.dart';
import '../../Services/AuthServices.dart';
import '../../Services/DataBaseService.dart';
import '../Home/Component.dart';
import '../SignUpScreen/SignUpScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = " ";
  String password = " ";
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  _isLoading
    ? Center(
    child: CircularProgressIndicator(
    color: Theme.of(context).primaryColor),
    )
        : Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/logo.gif',
                ),
                const RowComponent(t1: 'Catch', t2: ' Up!'),
                const SizedBox(
                  height: 50,
                ),

                // const TextFieldCustom(
                //   iconData: IconData(0xf018, fontFamily: 'MaterialIcons'),
                //   hint: 'Email',
                //   secure: false,
                // ),
                // const TextFieldCustom(
                //   iconData: IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                //   hint: 'Password',
                //   secure: true,
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 20, 40.0, 0),
                  child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                            IconData(0xf018, fontFamily: 'MaterialIcons'),
                            color: ConstantColors.pr),
                        hintText: 'Emaill',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(
                              20)),
                          borderSide: BorderSide(width: 2, color: ConstantColors
                              .pr),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                            ? null
                            : 'Please Enter a valid Email';
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 20, 40.0, 0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon:  Icon(
                          Icons.lock,
                          color: ConstantColors.pr),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(
                            20)),
                        borderSide: BorderSide(width: 2, color: ConstantColors
                            .pr),
                      ),
                    ),

                    validator: (val) {
                      if (val!.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),

                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .0666,
                  decoration: BoxDecoration(
                    color: ConstantColors.pr,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        login();
                        },
                      child: const Text('Login',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
             //   const ContainerButton(),

                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .0666,
                  decoration: BoxDecoration(
                    color: ConstantColors.pr,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        navigateToNextScreen(context, const SignUpScreen());

                      },
                      child: const Text('Sign Up',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
    login() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        await authService.loginWithUserNameandPassword(email, password)
            .then((value) async {
          if (value == true) {
            QuerySnapshot snapshot =
            await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            //فنكشن بنوخذ الايميل عشان تبحث اذا موجود بالداتا بيز وتعمل ماتش للفاليو وترجع سناب شوت
                .gettingUserData(email);
            // saving the values to our shared preferences
            await SharedPrefHelper.saveUserLoggedInStatus(true);
            await SharedPrefHelper.saveUserEmail(email);
            //رح تكون عبارة عن لستة
            await SharedPrefHelper.saveUserName(snapshot.docs[0]["fullName"]);
              navigateToNextScreenReplace(context,  HomeScreen());
          } else {
            showSnackbar(context, ConstantColors.pr, value);
            setState(() {
              _isLoading = false;
            });
          }
        });}}}
