import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user/components/rounded_button.dart';
import 'package:user/screens/login.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.4),
              ),
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/mohami.png',
                width: 220,
                height: 220.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: Container(
                  child: RoundedButton(
                    title: 'تسجيل الدخول ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ]));
  }
}
