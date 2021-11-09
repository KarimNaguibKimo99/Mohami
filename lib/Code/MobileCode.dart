import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user/Forget%20Password/mobile.dart';
import 'package:user/New%20Password/newpassword.dart';
import 'package:user/components/rounded_button.dart';

class MobileCode extends StatefulWidget {
  @override
  _MobileCodeState createState() => _MobileCodeState();
}

class _MobileCodeState extends State<MobileCode> {
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white.withOpacity(0.1),
              ),
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
                                builder: (context) => ForgetMobile()));
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        'كتابة رقم الكود للموبايل',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'رقم الكود',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'من فضلك ادخل رقم الكود',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  PinCodeTextField(
                    onChanged: (valueKey) {},
                    length: 4,
                    textStyle: TextStyle(color: Colors.white),
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "إعادة الارسال",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20.0),
                              ),
                            ),
                          ),
                          Text(
                            'هل لم تستلم الكود بعد؟',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: RoundedButton(
                      title: 'تأكيد',
                      colour: Colors.blueGrey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPasswordMobile()));
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
