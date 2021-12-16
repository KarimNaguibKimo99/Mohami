import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/constants.dart';
import 'package:el_mohami/pages/checkemail.dart';
import 'package:el_mohami/pages/search.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:string_validator/string_validator.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  //bool admin = true;
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('جد حسابك'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                color: admin
                                    ? Colors.blueGrey
                                    : Colors.transparent,
                                child: Center(
                                  child: Text(
                                    'ادمن',
                                    style: TextStyle(
                                      color:
                                          admin ? Colors.white : Colors.black,
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
                                color: admin
                                    ? Colors.transparent
                                    : Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    'عميل',
                                    style: TextStyle(
                                      color:
                                          admin ? Colors.black : Colors.white,
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
                      Text(
                        'اكتب الايميل',
                        style: TextStyle(fontSize: 25.0, color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _emailTextEditingController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isNotEmpty && isEmail(value)) {
                                return null;
                              } else {
                                return 'ادخل ايميل صحيح';
                              }
                            },
                            decoration: kTextFiledDecoration.copyWith(
                                isDense: true,
                                hintText: 'الايميل',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RoundedButton(
                          title: 'تاكيد ',
                          colour: Colors.blueGrey,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                FormData formData = new FormData.fromMap({
                                  'email': _emailTextEditingController.text,
                                });
                                var response = await _dio.post(
                                    'https://tawaklsa.com/moham/recover.php',
                                    data: formData);
                                if (response.statusCode == 200) {
                                  Elmohami.sharedPreferences.setString(
                                      Elmohami.isAdmin,
                                      response.data['is_admin']);
                                  Elmohami.sharedPreferences.setString(
                                      Elmohami.userEmail,
                                      _emailTextEditingController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmailCode(
                                        email: _emailTextEditingController.text,
                                      ),
                                    ),
                                  );
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
                                  builder: (context) => SearchMobile()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
