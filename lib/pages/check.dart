import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/newpasswordphone.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كتابة رقم الكود للموبايل'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
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
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'من فضلك ادخل رقم الكود',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                  PinCodeTextField(
                    onChanged: (valueKey) {},
                    length: 4,
                    textStyle: TextStyle(color: Colors.black),
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "إعادة الارسال",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15.0),
                            ),
                          ),
                        ),
                        Text(
                          'هل لم تستلم الكود بعد؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ],
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
                                builder: (context) => (NewPasswordMobile())));
                      },
                    ),
                  ),
                  RoundedButton(
                    title: 'مسح',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      // Navigator.push(context,
                      //  MaterialPageRoute(builder: (context) => SignUp()));
                    },
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
/* import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/newpasswordphone.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'من فضلك ادخل رقم الكود',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              PinCodeTextField(
                onChanged: (valueKey) {},
                length: 6,
                backgroundColor: Colors.white,
                textStyle: TextStyle(color: Colors.black),
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "إعادة الارسال",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 15.0),
                        ),
                      ),
                    ),
                    Text(
                      'هل لم تستلم الكود بعد؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ],
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
                            builder: (context) => (NewPasswordMobile())));
                  },
                ),
              ),
              RoundedButton(
                title: 'مسح',
                colour: Colors.blueGrey,
                onPressed: () {
                  // Navigator.push(context,
                  //  MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
