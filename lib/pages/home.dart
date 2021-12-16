import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/new%20file/Chat/chat_files.dart';
import 'package:el_mohami/notification/notedetails.dart';
import 'package:flutter/material.dart';
import 'package:el_mohami/new file/Chat/chat.dart';
import 'package:el_mohami/notification/notification.dart';
import 'package:el_mohami/pages/change_password.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
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
                //Navigator.of(context).pushReplacementNamed(LLogin.routeName);
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
    _fcm.getToken().then((value) {
      //print('device token : ' + value);
      FirebaseFirestore.instance
          .collection('tokens')
          .doc(Elmohami.sharedPreferences.getString(Elmohami.userUID))
          .set({
        'token': value,
      });
    });
    /* RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage?.data['type'] == 'notification') {
      Navigator.pushNamed(
        context,
        NoteDetails.routeName,
      );
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'notification') {
        Navigator.pushNamed(
          context,
          NoteDetails.routeName,
        );
      }
    }); */
    /* _fcm.getInitialMessage().then((RemoteMessage message) {
      Navigator.pushNamed(
        context,
        Note.routeName,
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Navigator.pushNamed(
        context,
        Note.routeName,
      );
      /* RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android; */

      /* if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      } */
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(
        context,
        Note.routeName,
      );
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            'images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 20.0, top: 5.0, right: 10.0, left: 10.0),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    child: Row(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text('ملفى'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                                builder: (context) =>
                                                    ChangePassword()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text('تغيير كلمة المرور'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                        Elmohami.sharedPreferences.setBool(
                                            Elmohami.staySigned, false);
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text('تسجيل الخروج'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(Icons.logout,
                                                  color: Colors.indigo[300]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Text(
                                'الرئيسية',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    alignment: Alignment.topCenter,
                    height: 220,
                    width: 220,
                    child: ClipRRect(
                      child: Image.asset(
                        'images/mohami.png',
                        height: 220.0,
                        width: 220,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          height: 100.0,
                          width: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.notification_important,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Note()));
                                  }),
                              Text(
                                'الاشعار',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          height: 100.0,
                          width: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.chat,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Chat()));
                                  }),
                              Text(
                                'الشات',
                                style: TextStyle(fontSize: 15.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        height: 100.0,
                        width: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.phone,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  await canLaunch('tel:01145919223')
                                      ? await launch('tel:01145919223')
                                      : _showMyDialog(
                                          'لا يمكن الاتصال بهذا الرقم');
                                }),
                            Text(
                              'الاتصال',
                              style: TextStyle(fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                        height: 100.0,
                        width: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.upload_file,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                                onPressed: () async {
                                  Navigator.of(context)
                                      .pushNamed(ChatFiles.routeName);
                                }),
                            Text(
                              'الملفات',
                              style: TextStyle(fontSize: 15.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
