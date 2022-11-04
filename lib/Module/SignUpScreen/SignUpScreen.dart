import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Helper/ConstHelper/ConstHelper.dart';
import '../../Helper/ShPreHelper/SharedPrefHelper.dart';
import '../../Services/AuthServices.dart';
import '../Home/Component.dart';
import '../Home/Home.dart';
import '../LoginPage/LoginPage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  String email = " ";
  String password = " ";
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : Form(
                key: formKey,
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.person, color: ConstantColors.pr),
                            hintText: 'Full Name',
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: 2, color: ConstantColors.pr),
                            ),
                          ),
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name can't be Empty";
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 20, 40.0, 0),
                        child: TextFormField(
                            obscureText: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                  const IconData(0xf018,
                                      fontFamily: 'MaterialIcons'),
                                  color: ConstantColors.pr),
                              hintText: 'Emaill',
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 2, color: ConstantColors.pr),
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
                            prefixIcon: Icon(
                                Icons.lock,
                                color: ConstantColors.pr),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: 2, color: ConstantColors.pr),
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

                      const SizedBox(height: 5),
                      const SizedBox(
                        height: 10,
                      ),
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
                              SignUp();
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Login now",
                                  style: TextStyle(
                                      color: ConstantColors.pr,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigateToNextScreen(
                                          context, const LoginPage());
                                    }),
                            ]),
                      ),
                    ])))));
  }

  SignUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signUpwithEmailAndPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
// حفظ بيانات المستخدم
          await SharedPrefHelper.saveUserLoggedInStatus(true);
          await SharedPrefHelper.saveUserName(fullName);
          await SharedPrefHelper.saveUserEmail(email);
          navigateToNextScreenReplace(context,  HomeScreen());

        } else {
          showSnackbar(context, ConstantColors.pr, value);
          setState(() {
            _isLoading = false;
          });

        }
      });
    }
  }
}
