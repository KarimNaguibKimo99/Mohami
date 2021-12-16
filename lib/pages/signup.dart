import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/lists.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService auth = AuthService();
  /* String _phoneNumberValidator(String value) {
    Pattern pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Phone Number';
    else
      return null;
  } */

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _mobileTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String gender;
  String groupValue = "male";
  bool hidePass = true;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/bg.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Container(
        color: Colors.black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
      ),
      SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 32.0, right: 32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Container(
                alignment: Alignment.topCenter,
                width: 280.0,
                height: 240.0,
                child: Image.asset('images/mohami.png'),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey,
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.end,
                              controller: _nameTextController,
                              decoration: InputDecoration(
                                  hintText: "الاسم بالكامل",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The name field cannot be empty";
                                }
                                return null;
                              },
                            ),
                            trailing: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey,
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              textAlign: TextAlign.end,
                              controller: _mobileTextController,
                              decoration: InputDecoration(
                                  hintText: "رقم الموبايل",
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                  border: InputBorder.none),
                              validator: (value) {
                                Pattern pattern =
                                    r'^(?:[+0][1-9])?[0-9]{10,12}$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Enter Valid Phone Number';
                                else
                                  return null;
                              },
                            ),
                            trailing: Icon(
                              Icons.mobile_screen_share,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              textAlign: TextAlign.end,
                              controller: _emailTextController,
                              decoration: InputDecoration(
                                  hintText: "الايميل",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (isEmail(value)) {
                                  return null;
                                } else {
                                  return 'Please make sure your email address is valid';
                                }
                                /* if (value.isEmpty) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value))
                    return 'Please make sure your email address is valid';
                  else
                    return null;
                } */
                              },
                            ),
                            trailing: Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: new Container(
                        color: Colors.white.withOpacity(0.4),
                        child: Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              title: Text(
                                "انثى",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Radio(
                                  value: "female",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            )),
                            Expanded(
                                child: ListTile(
                              title: Text(
                                "ذكر",
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Radio(
                                  value: "male",
                                  groupValue: groupValue,
                                  onChanged: (e) => valueChanged(e)),
                            )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                            textAlign: TextAlign.end,
                            controller: _passwordTextController,
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                hintText: "كلمة السر",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (value.length < 6) {
                                return "the password has to be at least 6 characters long";
                              }
                              return null;
                            },
                          ),
                          trailing: Icon(Icons.lock_open_outlined),
                          leading: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  hidePass = false;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                            textAlign: TextAlign.end,
                            controller: _confirmPasswordController,
                            obscureText: hidePass,
                            decoration: InputDecoration(
                                hintText: "تاكيد كلمة السر",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (value.length < 6) {
                                return "the password has to be at least 6 characters long";
                              } else if (value !=
                                  _passwordTextController.text) {
                                return "the password not identical";
                              }
                              return null;
                            },
                          ),
                          trailing: Icon(Icons.lock_outline),
                          leading: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  hidePass = false;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
              child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blueGrey,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        if (_formKey.currentState.validate()) {
                          await auth
                              .registerWithEmailAndPassword(
                                  _emailTextController.text,
                                  _passwordTextController.text,
                                  _nameTextController.text,
                                  _mobileTextController.text,
                                  groupValue)
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Lis(),
                                    ),
                                  ));
                        }
                      } catch (e) {
                        print(e.toString());
                        if (e.toString() ==
                            '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Existed account'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      }
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "سجل دخولك",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "هل لديك حساب بالفعل؟",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ))),
          ],
        ),
      ))
    ]));
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }
}
