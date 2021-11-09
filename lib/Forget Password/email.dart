import 'package:flutter/material.dart';
import 'package:user/Code/EmailCode.dart';
import 'package:user/Constants/constants.dart';
import 'package:user/Forget%20Password/mobile.dart';
import 'package:user/components/rounded_button.dart';
import 'package:user/screens/login.dart';

class ForgetEmail extends StatefulWidget {
  @override
  _ForgetEmailState createState() => _ForgetEmailState();
}

class _ForgetEmailState extends State<ForgetEmail> {
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                         Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CodeEmail()));
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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
                      'اكتب الايميل',
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
                          hintText: 'الايميل',
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
                                builder: (context) => CodeEmail()));
                      },
                    ),
                  ),
                  RoundedButton(
                    title: 'البحث بواسطة الرقم ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetMobile()));
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
