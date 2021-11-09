import 'package:flutter/material.dart';
import 'package:user/Code/EmailCode.dart';
import 'package:user/components/rounded_button.dart';
import 'package:user/screens/home.dart';

class NewPasswordMobile extends StatefulWidget {
  @override
  _NewPasswordMobileState createState() => _NewPasswordMobileState();
}

class _NewPasswordMobileState extends State<NewPasswordMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/5.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white.withOpacity(0.3),
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
                                builder: (context) => CodeEmail()));
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
                        'إعادة كتابة كلمة المرور',
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ' كلمة السر الجديدة',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: ' إعادة كلمة السر الجديدة',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: RoundedButton(
                        title: 'تأكيد ',
                        colour: Colors.blueGrey,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
