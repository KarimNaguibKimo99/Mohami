import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/new%20file/Chat/chat.dart';
import 'package:el_mohami/new%20file/Chat/chat_files.dart';
import 'package:el_mohami/new%20file/login.dart';
import 'package:el_mohami/notification/notedetails.dart';
import 'package:el_mohami/notification/notification.dart';
import 'package:el_mohami/pages/addcoustomer.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:el_mohami/pages/change_password.dart';
import 'package:el_mohami/pages/lists.dart';
import 'package:el_mohami/pages/signup.dart';
import 'package:el_mohami/pages/welcome.dart';
import 'package:el_mohami/services/el_mohami.dart';

import './pages/login.dart';

import './pages/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Elmohami.auth = auth.FirebaseAuth.instance;
  Elmohami.sharedPreferences = await SharedPreferences.getInstance();
  Elmohami.fireStore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Loading(),
      routes: {
        Login.routeName: (ctx) => Login(),
        LLogin.routeName: (ctx) => LLogin(),
        Coustomer.routeName: (ctx) => Coustomer(),
        Chat.routeName: (ctx) => Chat(),
        NoteDetails.routeName: (ctx) => NoteDetails(),
        Note.routeName: (ctx) => Note(),
        ChatFiles.routeName: (ctx) => ChatFiles(),
      },
    );
  }
}
