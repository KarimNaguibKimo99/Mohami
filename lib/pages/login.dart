import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/constants.dart';
import 'package:el_mohami/models/user.dart';
import 'package:el_mohami/new%20file/login.dart';
import 'package:el_mohami/pages/forget.dart';
import 'package:el_mohami/pages/home.dart';
import 'package:el_mohami/pages/signup.dart';
import 'package:el_mohami/services/auth.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;
import 'package:el_mohami/models/user.dart' as user;

import 'lists.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Dio _dio = Dio();
  String email;
  String password;
  bool valuefirst = false;
  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atention'),
          content: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
  }

  //bool admin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/3.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  /* Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    //color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              admin = !admin;
                            });
                          },
                          child: Container(
                            width: 100,
                            color: admin ? Colors.blueGrey : Colors.transparent,
                            child: Center(
                              child: Text(
                                'ادمن',
                                style: TextStyle(
                                  color: admin ? Colors.white : Colors.black,
                                  fontWeight: admin
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              admin = !admin;
                            });
                          },
                          child: Container(
                            width: 100,
                            color: admin ? Colors.transparent : Colors.blueGrey,
                            child: Center(
                              child: Text(
                                'عميل',
                                style: TextStyle(
                                  color: admin ? Colors.black : Colors.white,
                                  fontWeight: admin
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), */
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 300.0,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              //Do something with the user input.
                              setState(() {
                                email = value;
                              });
                            },
                            controller: _emailTextController,
                            /* validator: (value) {
                              if (isEmail(value)) {
                                return null;
                              } else {
                                return 'ايميل غير صحيح';
                              }
                            }, */
                            decoration: kTextFiledDecoration.copyWith(
                                isDense: true,
                                hintText: 'اسم المستخدم',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              //Do something with the user input.
                              setState(() {
                                password = value;
                              });
                            },
                            controller: _passwordTextController,
                            /* validator: (value) {
                              if (value.length < 6) {
                                return "كلمة مرور قصيرة";
                              }
                              return null;
                            }, */
                            decoration: kTextFiledDecoration.copyWith(
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'هل تذكرنى؟',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
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
                      colour: email.isNotEmpty && password.isNotEmpty
                          ? Colors.blueGrey
                          : Colors.grey,
                      onPressed: () async {
                        if (email.isNotEmpty && password.isNotEmpty) {
                          if (_formKey.currentState.validate()) {
                            try {
                              FormData formData = new FormData.fromMap({
                                'email': email,
                                'password': password,
                              });
                              var response = await _dio.post(
                                  'https://tawaklsa.com/moham/login.php',
                                  data: formData);
                              if (response.statusCode == 200) {
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.isAdmin,
                                    response.data.values.toList()[0]
                                        ['is_admin']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userUID,
                                    response.data.values.toList()[0]['id']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userEmail,
                                    response.data.values.toList()[0]['email']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userName,
                                    response.data.values.toList()[0]
                                        ['username']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userMobile,
                                    response.data.values.toList()[0]['mobile']);
                                Elmohami.sharedPreferences
                                    .setBool(Elmohami.staySigned, valuefirst);
                                /* print(
                                    'user id is ${Elmohami.sharedPreferences.getString(Elmohami.userUID)}');
                                print(
                                    'user id is ${Elmohami.sharedPreferences.getString(Elmohami.userName)}');
                                print(
                                    'user id is ${Elmohami.sharedPreferences.getString(Elmohami.userMobile)}');
                                print(response.data.values.toList()[0]['id']); */
                                response.data.values.toList()[0]['is_admin'] ==
                                        '1'
                                    ? Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LLogin(),
                                        ),
                                      )
                                    : Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                              } else {
                                print(response.statusCode);
                                setState(() {
                                  _showMyDialog('${response.statusCode}');
                                });
                              }
                            } on DioError catch (e) {
                              if (e.response.statusCode == 400) {
                                print(e.response.statusCode);
                                setState(() {
                                  _showMyDialog('تأكد من البيانات');
                                });
                              } else {
                                setState(() {
                                  _showMyDialog('حدث خطأ');
                                });
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                  /* Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: RoundedButton(
                      title: 'تسجيل الدخول',
                      colour: Colors.blueGrey,
                      onPressed: () async {
                        try {
                          if (_formKey.currentState.validate()) {
                            await auth
                                .signInWithEmailAndPassword(
                                    _emailTextController.text,
                                    _passwordTextController.text)
                                .then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Lis(),
                                    ),
                                  ),
                                );
                          }
                        } catch (e) {
                          if (e.toString() ==
                              '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                            setState(() {
                              _showMyDialog('Invalid Email');
                            });
                          } else if (e.toString() ==
                              '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                            setState(() {
                              _showMyDialog('Invalid Password');
                            });
                          }
                          print(e.toString());
                        }
                      },
                    ),
                  ), */
                  /* RoundedButton(
                    title: 'تسجيل حساب جديد ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                  Text(' : او تسجيل حساب جديد بواسطة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {
                            auth.signInWithFacebook().then((value) {
                              if (FirebaseAuth.instance.currentUser != null)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Lis(),
                                  ),
                                );
                            });
                          }),
                      IconButton(
                          icon: Image.asset('images/google-logo.png'),
                          onPressed: () {
                            auth.signInWithGoogle().then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Lis(),
                                    ),
                                  ),
                                );
                          }),
                    ],
                  ), */
                  /* Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                      child: Text(
                        "هل نسيت كلمة المرور؟",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ) */
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RoundedButton(
                      title: 'هل نسيت كلمة المرور؟',
                      colour: Colors.blueGrey,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
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
