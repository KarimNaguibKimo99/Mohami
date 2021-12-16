import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:el_mohami/notification/notedetails.dart';
import 'package:el_mohami/pages/home.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Note extends StatefulWidget {
  static String routeName = '/note';
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  static Future<void> sendNotification() async {
    var token = await getToken('1');
    print('token : $token');

    final data = {
      "notification": {
        "body": "اضغط للدخول للتطبيق",
        "title": "تم رؤية تفاصيل المقابلة من جهة العميل"
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
      await Dio(options)
          .post('https://fcm.googleapis.com/fcm/send', data: data);

      /* if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'تم الارسال');
      } else {
        print('حدث خطأ');
        // on failure do sth
      }*/
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset(
            'images/23.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('notification')
                .doc(Elmohami.sharedPreferences.getString(Elmohami.userUID))
                .collection('notifications')
                .orderBy('sendOrderTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                /* if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return Container();
                //return _buildErrorWidget(snapshot.data.error);
              } else */
                {
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      itemCount: snapshot.data.docs.length,
                      //reverse: true,
                      itemBuilder: (context, index) {
                        return snapshot.data.docs[index]['readTime'] == ''
                            ? GestureDetector(
                                onTap: () {
                                  print('updated1');
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection('notification')
                                        .doc(Elmohami.sharedPreferences
                                            .getString(Elmohami.userUID))
                                        .collection('notifications')
                                        .doc('${snapshot.data.docs[index].id}')
                                        .set({
                                      'email': snapshot.data.docs[index]
                                          ['email'],
                                      'date': snapshot.data.docs[index]['date'],
                                      'time': snapshot.data.docs[index]['time'],
                                      'location': snapshot.data.docs[index]
                                          ['location'],
                                      'message': snapshot.data.docs[index]
                                          ['message'],
                                      'sendTime': snapshot.data.docs[index]
                                          ['sendTime'],
                                      'sendOrderTime': snapshot.data.docs[index]
                                          ['sendOrderTime'],
                                      'readTime':
                                          DateFormat('yyyy-MM-dd - hh:mm')
                                              .format(DateTime.now())
                                              .toString(),
                                      'readOrderTime':
                                          DateTime.now().toIso8601String(),
                                      'read': 'false'
                                    });
                                    FirebaseFirestore.instance
                                        .collection('adminNotification')
                                        .doc()
                                        .set({
                                      'userName': Elmohami.sharedPreferences
                                          .getString(Elmohami.userName),
                                      'readTime':
                                          DateFormat('yyyy-MM-dd - hh:mm')
                                              .format(DateTime.now())
                                              .toString(),
                                      'readOrderTime':
                                          DateTime.now().toIso8601String(),
                                      'read': 'false'
                                    });
                                    sendNotification();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteDetails(
                                          date: snapshot.data.docs[index]
                                              ['date'],
                                          location: snapshot.data.docs[index]
                                              ['location'],
                                          time: snapshot.data.docs[index]
                                              ['time'],
                                          details: snapshot.data.docs[index]
                                              ['message'],
                                        ),
                                      ),
                                    );
                                    /* snapshot.data.docs.forEach((doc) {
                                  print('${doc.id}');
                                  print(
                                      '${snapshot.data.docs[index].id}');
                                  if (doc.id ==
                                      snapshot.data.docs[index].id) {
                                    doc.update({'read': 'true'});
                                    print('updated2');
                                  }
                                }); */
                                    /* print(snapshot.data.docs[index].id);
                                snapshot.data.docs[index]
                                    .update({'read': 'true'}); */
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.remove_red_eye),
                                    Text(snapshot.data.docs[index]['sendTime']),
                                    Text('اشعار جديد '),
                                    Icon(Icons.notifications_active)
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteDetails(
                                        date: snapshot.data.docs[index]['date'],
                                        location: snapshot.data.docs[index]
                                            ['location'],
                                        time: snapshot.data.docs[index]['time'],
                                        details: snapshot.data.docs[index]
                                            ['message'],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()));
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        'الاشعار',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                        /* return snapshot.data.docs[index].id ==
                              Elmohami.sharedPreferences
                                  .getString(Elmohami.userUID)
                          ? Center(
                              child:
                                  Text(snapshot.data.docs[index]['location']))
                          : Container(); */
                        /* return snapshot.data.docs.map((doc) {
                        print(doc.id);
                        print('location : ' + doc['location']);
                        return Center(child: Text(doc['location']));
                      }).toList(); */
                        /* return snapshot.data.docs.forEach((doc) {
                        print(doc.id);
                        print('location : ' + doc['location']);
                        return Center(child: Text(doc['location']));
                      }); */
                        //return Text(snapshot.data.docs[0]['location']);
                        //return Text(index.toString());
                      });
                  /* return ListView(
                  children: [
                    snapshot.data.documents.map((doc) {
                      return Text(doc.data()['location']);
                    }).toList()
                    /* Container(
                      height: 300,
                      width: 300,
                      color: Colors.blue,
                    ) */
                  ],
                ); */
                }
              } else if (snapshot.hasError) {
                return Container();
                //return _buildErrorWidget(snapshot.data.error);
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()),
                );
                //return _buildLoadingWidget();
              }
            },
          ),
        ],
      )),
    );
  }
}

_buildUserWidget(var data) {}
/* Stack(
          children: [
            Image.asset(
              'images/4.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          'الاشعار',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteDetails()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار جديد '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye),
                            Text('20-4-2020'),
                            Text('اشعار '),
                            Icon(Icons.notifications_active)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), */
