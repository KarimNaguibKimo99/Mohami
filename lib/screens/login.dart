import 'package:flutter/material.dart';
import 'package:user/Constants/constants.dart';
import 'package:user/Forget%20Password/email.dart';
import 'package:user/components/rounded_button.dart';
import 'package:user/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 45.0, left: 50.0, right: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                      width: 300.0,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          //Do something with the user input.
                          email = value;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                            isDense: true,
                            hintText: 'اسم المستخدم',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue.withOpacity(0.2),
                      ),
                      width: 300.0,
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          //Do something with the user input.
                          password = value;
                        },
                        decoration: kTextFiledDecoration.copyWith(
                            isDense: true,
                            hintText: 'كلمة المرور',
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'هل تذكرنى؟',
                          style: TextStyle(color: Colors.white),
                        ),
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            value: this.valuefirst,
                            onChanged: (bool value) {
                              setState(() {
                                this.valuefirst = value;
                              });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RoundedButton(
                      title: 'تاكيد',
                      colour: Colors.grey.withOpacity(0.5),
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RoundedButton(
                      title: 'هل نسيت كلمة المرور؟',
                      colour: Colors.blueGrey.withOpacity(0.8),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetEmail()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
