import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/infromation/form.dart';
import 'package:el_mohami/new%20file/infromation/searchcustomer.dart';
import 'package:el_mohami/notification/admin_notification.dart';
import 'package:el_mohami/pages/change_password.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LLogin extends StatefulWidget {
  static String routeName = '/llogin';
  @override
  _LLoginState createState() => _LLoginState();
}

class _LLoginState extends State<LLogin> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((value) {
      //print('device token : ' + value);
      FirebaseFirestore.instance
          .collection('tokens')
          .doc(Elmohami.sharedPreferences.getString(Elmohami.userUID))
          .set({
        'token': value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminNotification(),
                  ),
                );
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.notifications_active)))
        ],
        title: Row(
          children: [
            PopupMenuButton(
                icon: Icon(Icons.dehaze_sharp),
                itemBuilder: (context) => <PopupMenuItem<InkWell>>[
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('ملفى'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.person,
                                      color: Colors.indigo[300]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePassword()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('تغيير كلمة المرور'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.person,
                                      color: Colors.indigo[300]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () async {
                            /* await auth.signOut().then(
                              (value) {
                                Elmohami.sharedPreferences
                                    .setBool(Elmohami.staySigned, false);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                            ); */
                            Elmohami.sharedPreferences
                                .setBool(Elmohami.staySigned, false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('تسجيل الخروج'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.logout,
                                      color: Colors.indigo[300]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
            SizedBox(
              width: 10.0,
            ),
            IconButton(icon: Icon(Icons.crop_free), onPressed: () {}),
            SizedBox(
              width: 60.0,
            ),
            Text('الرئيسية ')
          ],
        ),
      ),
      /* endDrawer: Drawer(
        child: Container(
          color: Colors.blue[900],
          child: new ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('ملفى'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.person, color: Colors.indigo[300]),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('تغيير كلمة المرور'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.person, color: Colors.indigo[300]),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LLogin()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('تسجيل الخروج'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.logout, color: Colors.indigo[300]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), */
      body: Stack(
        children: [
          Image.asset(
            'images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: RoundedButton(
                        title: 'عميل جديد ',
                        colour: Colors.blueGrey,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Information()));
                        },
                      ),
                    ),
                    RoundedButton(
                      title: 'التواصل مع العميل',
                      colour: Colors.blueGrey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchCustomer()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
