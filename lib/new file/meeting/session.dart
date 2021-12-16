import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/Chat/chat.dart';
import 'package:el_mohami/new%20file/Chat/chat_files.dart';
import 'package:el_mohami/new%20file/infromation/date.dart';
import 'package:el_mohami/new%20file/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';
import 'package:el_mohami/models/customer.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Session extends StatefulWidget {
  final String title;
  final Customer customer;
  Session({@required this.title, @required this.customer});
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  _chooseNumberDialog(String num1, String num2) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Set backup account'),
          children: [
            SimpleDialogItem(
              icon: Icons.phone,
              color: Colors.orange,
              text: num1,
              onPressed: () async {
                await canLaunch('tel:$num1')
                    ? await launch('tel:$num1')
                    : _showMyDialog('لا يمكن الاتصال بهذا الرقم');
              },
            ),
            SimpleDialogItem(
              icon: Icons.phone,
              color: Colors.green,
              text: num2,
              onPressed: () async {
                await canLaunch('tel:$num2')
                    ? await launch('tel:$num2')
                    : _showMyDialog('لا يمكن الاتصال بهذا الرقم');
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> sendNotification(receiver, msg) async {
    var token = await getToken(receiver);
    print('token : $token');

    final data =
        /* {
      "message": {
        "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
        "notification": {
          "body": "This is an FCM notification message!",
          "title": "FCM Message"
        },
        'type': 'notification',
      }
    } */

        {
      "notification": {
        "body": "اضغط للدخول للتطبيق",
        "title": "تم تحديد ميعاد"
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAEO9HXXM:APA91bFrJqfBBlv_KjHOmw3EfVgx0fDFFeNkmiZeIFTajgZbGYoQI153H2trKCuhmwC-kjhsxptwNb2_fah_SM-6OwHhUHb4h6LuNXi7ar_pOEyPAv5CRzmt5__PDdzXxHggQpDf4uth'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      /* final response = await Dio(options).post(
          'https://fcm.googleapis.com/v1/projects/elmohami-f8c6f/messages:send',
          data: data); */
      final response = await Dio(options)
          .post('https://fcm.googleapis.com/fcm/send', data: data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'تم الارسال');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
  }

  static Future<String> getToken(userId) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var token;
    await _db.collection('tokens').doc(userId).get().then((snapshot) {
      token = snapshot['token'];
      print(snapshot['token']);
    });
    /* .getDocuments().then((snapshot){
              snapshot.documents.forEach((doc){
                token = doc.documentID;
              });
        }); */

    return token;
  }

  //final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String formattedTime;
  String formattedDate;
  String address;
  String notes;
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
                Navigator.of(context).pushReplacementNamed(LLogin.routeName);
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
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/5.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Column(
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 250,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (formattedDate != null) {
                                return null;
                              } else {
                                return 'اختر التاريخ';
                              }
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: formattedDate == null
                                  ? 'التاريخ'
                                  : formattedDate,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
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
                            onTap: () async {
                              final DateTime pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: currentDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050));
                              if (pickedDate != null)
                                setState(() {
                                  currentDate = pickedDate;
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                  currentDate = pickedDate;
                                });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 80,
                            width: 250,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              readOnly: true,
                              validator: (value) {
                                if (formattedTime != null) {
                                  return null;
                                } else {
                                  return 'اختر الوقت';
                                }
                              },
                              onTap: () async {
                                final TimeOfDay picked = await showTimePicker(
                                  initialTime: currentTime,
                                  context: context,
                                );
                                MaterialLocalizations localizations =
                                    MaterialLocalizations.of(context);

                                if (picked != null)
                                  setState(() {
                                    formattedTime =
                                        localizations.formatTimeOfDay(picked,
                                            alwaysUse24HourFormat: false);
                                    currentTime = picked;
                                  });
                              },
                              decoration: InputDecoration(
                                hintText: formattedTime == null
                                    ? 'الوقت'
                                    : formattedTime,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 80,
                            width: 250,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'اكتب العنوان';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  address = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'العنوان',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 80,
                            width: 250,
                            child: TextFormField(
                              maxLength: null,
                              maxLines: null,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  notes = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'الملاحظات',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Container(
                            width: 130,
                            child: RoundedButton(
                                title: 'الإتصال',
                                colour: Colors.blueGrey,
                                onPressed: () async {
                                  print(widget.customer.altPhone);
                                  if (widget.customer.altPhone == '') {
                                    await canLaunch(
                                            'tel:${widget.customer.phone}')
                                        ? await launch(
                                            'tel:${widget.customer.phone}')
                                        : _showMyDialog(
                                            'لا يمكن الاتصال بهذا الرقم');
                                  } else {
                                    _chooseNumberDialog(
                                        '${widget.customer.phone}',
                                        '${widget.customer.altPhone}');
                                  }
                                }
                                /* () async {
                                await canLaunch('tel:${widget.customer.phone}')
                                    ? await launch(
                                        'tel:${widget.customer.phone}')
                                    : _showMyDialog(
                                        'لا يمكن الاتصال بهذا الرقم');
                                //  Navigator.push(context,
                                //  MaterialPageRoute(builder: (context) => Chat()));
                              }, */
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            width: 130,
                            child: RoundedButton(
                              title: 'الشات',
                              colour: Colors.blueGrey,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chat(
                                      customer: widget.customer,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          width: 130,
                          child: RoundedButton(
                            title: 'ارسال ملف',
                            colour: Colors.blueGrey,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatFiles(
                                          customer: widget.customer,
                                        )),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        child: RoundedButton(
                          title: 'ارسال التفاصيل',
                          colour: Colors.blueGrey,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                sendNotification(widget.customer.id, 'Hi');
                                FirebaseFirestore.instance
                                    .collection('notification')
                                    .doc(widget.customer.id)
                                    .collection('notifications')
                                    .doc()
                                    .set({
                                      'email': widget.customer.email,
                                      'date': formattedDate,
                                      'time': formattedTime,
                                      'location': address,
                                      'message': notes,
                                      'sendTime':
                                          DateFormat('yyyy-MM-dd - hh:mm')
                                              .format(DateTime.now())
                                              .toString(),
                                      'readTime': '',
                                      'sendOrderTime':
                                          DateTime.now().toIso8601String(),
                                      'readOrderTime': '',
                                      'read': 'false'
                                    })
                                    .whenComplete(() => setState(() {
                                          _showMyDialog('تم الارسال');
                                        }))
                                    .catchError((e) => setState(() {
                                          _showMyDialog('${e.toString()}');
                                        }));
                                /* FormData formData = new FormData.fromMap({
                                  'email': widget.customer.email,
                                  'date': formattedDate,
                                  'time': formattedTime,
                                  'location': address,
                                  'message': notes
                                });
                                var response = await _dio.post(
                                    'https://tawaklsa.com/moham/notification.php',
                                    data: formData);
                                if (response.statusCode == 200) {
                                  setState(() {
                                    _showMyDialog('تم الارسال');
                                  });
                                } else {
                                  print(response.statusCode);
                                  setState(() {
                                    _showMyDialog('حدث خطأ حاول مجددا');
                                  });
                                } */
                              } catch (e) {
                                setState(() {
                                  _showMyDialog('${e.toString()}');
                                });
                              }
                            }
                            //  Navigator.push(context,
                            //  MaterialPageRoute(builder: (context) => Chat()));
                          },
                        ),
                      ),
                    ],
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

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
