import 'package:el_mohami/new%20file/login.dart';
import 'package:el_mohami/new%20file/sign-in/sign.dart';
import 'package:el_mohami/pages/home.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingState();
  }
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    getHome();
  }

  void getHome() async {
    await Future.delayed(Duration(seconds: 3));
    print(Elmohami.sharedPreferences.getBool(Elmohami.staySigned));
    if (Elmohami.sharedPreferences.getBool(Elmohami.staySigned) == true) {
      if (Elmohami.sharedPreferences.getString(Elmohami.isAdmin) == '1') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LLogin()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Home()));
      }
    } else
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Sign()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Image.asset(
          'images/loading.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ]),
    );
  }
}
