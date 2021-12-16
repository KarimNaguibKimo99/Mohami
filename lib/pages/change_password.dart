import 'dart:ui';

import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/constants.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/services/auth.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  Dio _dio = Dio();
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
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغيير كلمة السر"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'images/3.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _oldPasswordTextController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return 'ادخل كلمة سر صحيحة';
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'كلمة السر القديمة',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "ادخل كلمة السر";
                              } else if (value.length < 6) {
                                return "كلمة السر لا تقل عن 6 احرف";
                              }
                              return null;
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: ' كلمة السر الجديدة',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: _confirmPasswordTextController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "اعد كتابة كلمة السر";
                              } else if (value.length < 6) {
                                return "كلمة السر لا تقل عن 6 احرف";
                              } else if (value !=
                                  _passwordTextController.text) {
                                return "كلمة السر غير متطابقة";
                              }
                              return null;
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: ' إعادة كلمة السر الجديدة',
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent, width: 2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      title: 'تأكيد ',
                      colour: Colors.blueGrey,
                      onPressed: () async {
                        try {
                          if (_formKey.currentState.validate()) {
                            print(Elmohami.sharedPreferences
                                .getString(Elmohami.userUID));
                            print(
                                'old password is ${_oldPasswordTextController.text}');
                            print(
                                'new password is ${_passwordTextController.text}');
                            FormData formData = new FormData.fromMap({
                              'id': Elmohami.sharedPreferences
                                  .getString(Elmohami.userUID),
                              'old_password': _oldPasswordTextController.text,
                              'new_password': _passwordTextController.text,
                              'is_admin': Elmohami.sharedPreferences
                                  .getString(Elmohami.isAdmin),
                            });
                            var response = await _dio.post(
                                'https://tawaklsa.com/moham/changepass.php',
                                data: formData);

                            if (response.statusCode == 200) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            }
                            /* else if (response.statusCode == 400) {
                              setState(() {
                                _showMyDialog('كلمة السر القديمة غير صحيحة');
                              });
                            } else {
                              _showMyDialog('1حدث خطأ حاول مجددا');
                            } */

                            /* await auth
                                .validateUser(_oldPasswordTextController.text)
                                .then((value) async {
                              if (value) {
                                await auth
                                    .updatePassword(
                                        _passwordTextController.text)
                                    .then(
                                      (value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ),
                                      ),
                                    );
                              } else
                                setState(() {
                                  _showMyDialog();
                                });
                            }); */
                          }
                        } on DioError catch (e) {
                          if (e.response.statusCode == 400) {
                            print(e.response.statusCode);
                            setState(() {
                              _showMyDialog('كلمة السر القديمة غير صحيحة');
                            });
                          } else {
                            setState(() {
                              _showMyDialog('حدث خطأ');
                            });
                          }
                        }
                      },
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
