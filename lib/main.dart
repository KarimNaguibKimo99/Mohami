import 'package:flutter/material.dart';
import 'package:user/Change%20Password/changepassword.dart';
import 'package:user/Code/EmailCode.dart';
import 'package:user/Forget%20Password/email.dart';
import 'package:user/New%20Password/newpassword.dart';
import 'package:user/chat/chat.dart';
import 'package:user/notification/notedetails.dart';
import 'package:user/notification/notification.dart';
import 'package:user/screens/home.dart';
import 'package:user/screens/login.dart';
import 'package:user/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.black, // <-- your color
      ),
      home: Loading(),
    );
  }
}
