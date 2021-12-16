import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:el_mohami/notification/notedetails.dart';
import 'package:el_mohami/pages/home.dart';
import 'package:intl/intl.dart';

class AdminNotification extends StatefulWidget {
  @override
  _AdminNotificationState createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
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
                  .collection('adminNotification')
                  /* .doc('132')
            .collection('notifications')*/
                  .orderBy('readOrderTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(
                      child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return snapshot.data.docs[index]['read'] == 'false'
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('adminNotification')
                                      .doc(snapshot.data.docs[index].id)
                                      .update({
                                    'read': 'true',
                                  });
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Icon(Icons.remove_red_eye),
                                  Text(snapshot.data.docs[index]['readTime']),
                                  Flexible(
                                    child: Text(
                                      ' رأى التفاصيل ${snapshot.data.docs[index]['userName']}',
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Icon(Icons.notifications_active)
                                ],
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(snapshot.data.docs[index]['readTime']),
                                  Flexible(
                                    child: Text(
                                      ' رأى التفاصيل ${snapshot.data.docs[index]['userName']}',
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                ],
                              ),
                            );
                    },
                  ));
                } else if (snapshot.hasError) {
                  return SafeArea(
                    child: Container(
                      child: Center(child: Text('snapshot has error')),
                    ),
                  );
                } else {
                  return SafeArea(
                    child: Container(
                      child: Center(child: Text('loading')),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
