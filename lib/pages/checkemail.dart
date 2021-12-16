import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/newpasswordphone.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:dio/dio.dart';

class EmailCode extends StatefulWidget {
  final String email;
  EmailCode({@required this.email});
  @override
  _EmailCodeState createState() => _EmailCodeState();
}

class _EmailCodeState extends State<EmailCode> {
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

  TextEditingController _codeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Dio _dio = Dio();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('كتابة رقم الكود للايميل'),
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
                  Form(
                    key: _formKey,
                    child: PinCodeTextField(
                      controller: _codeTextController,
                      validator: (value) {
                        if (value.length == 4) {
                          return null;
                        } else {
                          return 'ادخل رقم كود مكون من 4 أرقام';
                        }
                      },
                      errorTextSpace: 30,
                      autoFocus: true,
                      onChanged: (valueKey) {},
                      length: 4,
                      textStyle: TextStyle(color: Colors.black),
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            try {
                              FormData formData = new FormData.fromMap({
                                'username': widget.email,
                                'is_admin': Elmohami.sharedPreferences
                                    .getString(Elmohami.isAdmin),
                              });
                              var response = await _dio.post(
                                  'https://tawaklsa.com/moham/recover.php',
                                  data: formData);
                              if (response.statusCode != 200) {
                                setState(() {
                                  _showMyDialog('حدث خطأ');
                                });
                              } else {
                                setState(() {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (EmailCode(
                                        email: widget.email,
                                      )),
                                    ),
                                  );
                                  _showMyDialog('تم ارسال الكود');
                                });
                              }
                            } catch (e) {
                              print('حدث خطأ');
                            }
                          },
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            FormData formData = new FormData.fromMap({
                              'username': widget.email,
                              'is_admin': Elmohami.sharedPreferences
                                  .getString(Elmohami.isAdmin),
                              'otp': _codeTextController.text,
                            });
                            var response = await _dio.post(
                                'https://tawaklsa.com/moham/otp.php',
                                data: formData);
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => (NewPasswordMobile()),
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
