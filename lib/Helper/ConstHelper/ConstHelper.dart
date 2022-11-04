import 'dart:ui';

import 'package:flutter/material.dart';

class ConstantColors {
 static   Color pr = const Color(0xFF6C19FF);
 static   Color bl = const Color(0xFF00B3D7);


}
class ConstantKeys {
static String apiKey = "AIzaSyBFubOrY6H2Mcu_-mVEsksjYJYrQcoZqqU";
static String appId ="1:194344324051:web:7c712b619a93a4a8f03d26";
static String messagingSenderId = "194344324051";
static String projectId = "flutter-course-32a21";


}
//nav helper
void navigateToNextScreen(context, page){
 Navigator.push(context ,MaterialPageRoute(builder: (context) => page)  );

}
void navigateToNextScreenReplace(context, page){
 Navigator.pushReplacement(context ,MaterialPageRoute(builder: (context) => page)  );

}