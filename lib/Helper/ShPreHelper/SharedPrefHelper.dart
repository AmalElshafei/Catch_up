import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefHelper {
//حفظ بيانات المستخدم
  static String UserLoginStatus = 'UserLoginKey';
  static String UserNameKey = 'UselNameKey';
  static String UserEmailKey = 'UserEmailKey';

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(UserLoginStatus, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(UserNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(UserEmailKey, userEmail);
  }



  static Future<bool?> getUserLoginStatus() async{
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//bool value لتشوف اذا هاد الكي موجود او لا بترجع ترو او فولز
sharedPreferences.getBool(UserLoginStatus);
}
  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(UserEmailKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(UserNameKey);
  }
}

