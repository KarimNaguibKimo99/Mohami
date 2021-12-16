import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/2.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/mohami.png',
              width: 220,
              height: 220.0,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: RoundedButton(
                  title: 'تسجيل دخول ',
                  colour: Colors.blueGrey,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    ]));
  }
}
