import 'package:flutter/material.dart';
import 'package:flutter_course/Helper/ConstHelper/ConstHelper.dart';
import 'package:flutter_course/Module/Home/Home.dart';
import 'package:flutter_course/Module/SignUpScreen/SignUpScreen.dart';

class RowComponent extends StatelessWidget {
  final String t1;
  final String t2;

  const RowComponent({Key? key, required this.t1, required this.t2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: ConstantColors.pr),
        ),
        Text(
          t2,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: ConstantColors.bl),
        ),
      ],
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final bool secure;

  const TextFieldCustom(
      {Key? key,
      required this.iconData,
      required this.hint,
      required this.secure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20, 40.0, 0),
      child: TextField(
        obscureText: secure,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: ConstantColors.pr),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 2, color: ConstantColors.pr),
          ),
        ),
        onChanged: (val){
        },
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  const ContainerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
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

                },
                child: const Text('Login',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: const Text('Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Cont extends StatelessWidget {
  const Cont({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .0666,
        decoration: BoxDecoration(
          color: ConstantColors.pr,
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

