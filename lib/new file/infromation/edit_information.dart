import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/infromation/searchcustomer.dart';
import 'package:el_mohami/new%20file/infromation/thank.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:dio/dio.dart';

class EditInformation extends StatefulWidget {
  final String username;
  final String password;
  final String location;
  final String email;
  final String mobile;
  final String mobileAlt;
  final String caseTitle;

  EditInformation({
    @required this.username,
    @required this.password,
    @required this.location,
    @required this.email,
    @required this.mobile,
    @required this.mobileAlt,
    @required this.caseTitle,
  });
  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final Dio _dio = Dio();
  final formKey = new GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _mobileTextController = TextEditingController();
  TextEditingController _mobileAltTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  String dropdownValue = 'جنائي';
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

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.caseTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ادخال بيانات العميل لدى المكتب'),
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.username,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "ادخل اسم العميل";
                          }
                          return null;
                        },
                        //controller: _nameTextController,
                        decoration: InputDecoration(
                          hintText: 'اسم العميل',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.location,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "ادخل العنوان";
                          }
                          return null;
                        },
                        //controller: _addressTextController,
                        decoration: InputDecoration(
                          hintText: 'العنوان',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.email,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        //controller: _emailTextController,
                        validator: (value) {
                          if (isEmail(value)) {
                            return null;
                          } else {
                            return 'تأكد من صحة البريد الالكتروني';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'البريد الالكترونى',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.password,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.length < 6) {
                            return "كلمة مرور قصيرة";
                          }
                          return null;
                        },
                        /* validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل الرقم السرى';
                          }
                          return null;
                        }, */
                        //controller: _passwordTextController,
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.mobile,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //controller: _mobileTextController,
                        validator: (value) {
                          /* Pattern pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                          RegExp regex = new RegExp(pattern); */
                          /* if (!isNumeric(value) ||
                              value.length != 11 ||
                              !value.startsWith('01')) {
                            return 'ادخل رقم هاتف صحيح';
                          } else {
                            return null;
                          } */
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'التليفون',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: widget.mobileAlt,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //controller: _mobileAltTextController,
                        validator: (value) {
                          /* Pattern pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
                          RegExp regex = new RegExp(pattern); */
                          /* if (!isNumeric(value) ||
                              value.length != 11 ||
                              !value.startsWith('01')) {
                            return 'ادخل رقم هاتف صحيح';
                          } else {
                            return null;
                          } */
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'التليفون اخر',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 60),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButton(
                                  dropdownColor: Colors.white,
                                  items: <String>[
                                    'جنائى',
                                    'عسكرى',
                                    'تهرب ضريبى',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                    );
                                  }).toList(),
                                  value: dropdownValue,
                                  iconSize: 24,
                                  iconEnabledColor: Colors.black,
                                  style: const TextStyle(color: Colors.white),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueGrey,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                ),
                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              ': نوع القضية ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 19.0),
                            ),
                          ),
                        ],
                      ),
                    ), */
                    RoundedButton(
                      title: 'تأكيد ',
                      colour: Colors.blueGrey,
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          try {
                            FormData formData = new FormData.fromMap({
                              'username':
                                  _nameTextController.text.toLowerCase(),
                              'password': _passwordTextController.text,
                              'location': _addressTextController.text,
                              'email': _emailTextController.text,
                              'mobile': _mobileTextController.text,
                              'mobile_alt': _mobileAltTextController.text,
                              'case': dropdownValue,
                            });
                            var response = await _dio.post(
                                'https://tawaklsa.com/moham/edit_client.php',
                                data: formData);
                            if (response.statusCode == 200) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(response.data.values.toList()[0]['id'])
                                  .set({
                                'id': response.data.values.toList()[0]['id'],
                                'username': response.data.values.toList()[0]
                                    ['username'],
                                'password': response.data.values.toList()[0]
                                    ['password'],
                                'location': response.data.values.toList()[0]
                                    ['location'],
                                'email': response.data.values.toList()[0]
                                    ['email'],
                                'mobile': response.data.values.toList()[0]
                                    ['mobile'],
                                'mobile_alt': response.data.values.toList()[0]
                                    ['mobile_alt'],
                                'case': response.data.values.toList()[0]
                                    ['case_title'],
                                'chattingWith': '',
                              });
                              print(response.data.values.toList()[0]['id']);
                              print(
                                  response.data.values.toList()[0]['username']);
                              print(
                                  response.data.values.toList()[0]['password']);
                              print(
                                  response.data.values.toList()[0]['location']);
                              print(response.data.values.toList()[0]['email']);
                              print(response.data.values.toList()[0]['mobile']);
                              print(response.data.values.toList()[0]
                                  ['case_title']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Thanks()));
                            } else {
                              setState(() {
                                _showMyDialog('حدث خطأ حاول مجددا');
                              });
                            }
                          } on DioError catch (e) {
                            if (e.response.statusCode == 400) {
                              setState(() {
                                _showMyDialog('رمز التأكيد المؤقت خاطئ');
                              });
                            } else {
                              setState(() {
                                _showMyDialog('حدث خطأ حاول مجددا');
                              });
                            }
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
