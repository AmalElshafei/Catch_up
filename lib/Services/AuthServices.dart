import 'package:firebase_auth/firebase_auth.dart';

import '../Helper/ShPreHelper/SharedPrefHelper.dart';
import 'DataBaseService.dart';

//استخدام الاوث ل login ,reg , logout
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //رح يكون عنا لل لوق والساين والساين اوت
  //هاندل لكل الايرور من الفير بيز
  Future signUpwithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      //اذا بيانات اليوزر مش فارغة يتم حفظهم بواسطة الداتا بيز سيرفس
      if (user != null) {
        //نوخذ بيانات اليوزر ونرجع ترو او نعمل ابديت عليهم
        await DataBaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await SharedPrefHelper.saveUserLoggedInStatus(false);
      await SharedPrefHelper.saveUserEmail("");
      await SharedPrefHelper.saveUserName("");
      await firebaseAuth.signOut();
      signOut();
    } catch (e) {
      return null;
    }
  }
}
