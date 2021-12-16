import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/login.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NewPasswordMobile extends StatefulWidget {
  @override
  _NewPasswordMobileState createState() => _NewPasswordMobileState();
}

class _NewPasswordMobileState extends State<NewPasswordMobile> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
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
        title: Text('ادخال كلمة سر جديدة'),
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
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
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
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                    /* TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: ' كلمة السر الجديدة',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: ' إعادة كلمة السر الجديدة',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                      ),
                    ), */
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: RoundedButton(
                        title: 'تأكيد ',
                        colour: Colors.blueGrey,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              FormData formData = new FormData.fromMap({
                                'email': Elmohami.sharedPreferences
                                    .getString(Elmohami.userEmail),
                                'password': _passwordTextController.text,
                                'is_admin': Elmohami.sharedPreferences
                                    .getString(Elmohami.isAdmin),
                              });
                              var response = await _dio.post(
                                  'https://tawaklsa.com/moham/updatepass.php',
                                  data: formData);
                              if (response.statusCode == 200) {
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userUID,
                                    response.data.values.toList()[0]['id']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userEmail,
                                    response.data.values.toList()[0]['email']);
                                Elmohami.sharedPreferences.setString(
                                    Elmohami.userMobile,
                                    response.data.values.toList()[0]['mobile']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LLogin(),
                                  ),
                                );
                              }
                            } on DioError catch (e) {
                              if (e.response.statusCode == 400) {
                                setState(() {
                                  _showMyDialog('رمز التأكيد المؤقت خاطئ');
                                });
                              } else {
                                setState(() {
                                  _showMyDialog('حدث خطأ');
                                });
                              }
                            }
                          }
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
/* import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:flutter/material.dart';

class NewPasswordMobile extends StatefulWidget {
  @override
  _NewPasswordMobileState createState() => _NewPasswordMobileState();
}

class _NewPasswordMobileState extends State<NewPasswordMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إعادة كتابة كلمة المرور"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
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
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: ' إعادة كلمة السر الجديدة',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 15.0),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
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
                              MaterialPageRoute(builder: (context) => Login()));
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
 */
