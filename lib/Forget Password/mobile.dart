import 'package:flutter/material.dart';
import 'package:user/Code/MobileCode.dart';
import 'package:user/Constants/constants.dart';
import 'package:user/Forget%20Password/email.dart';
import 'package:user/components/rounded_button.dart';
import 'package:user/screens/login.dart';

class ForgetMobile extends StatefulWidget {
  @override
  _ForgetMobileState createState() => _ForgetMobileState();
}

class _ForgetMobileState extends State<ForgetMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              height: 40.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Text(
                      'اكتب الرقم',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kTextFiledDecoration.copyWith(
                          isDense: true,
                          hintText: 'الرقم',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RoundedButton(
                      title: 'تاكيد ',
                      colour: Colors.blueGrey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MobileCode()));
                      },
                    ),
                  ),
                  RoundedButton(
                    title: 'البحث بواسطة الايميل ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetEmail()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
