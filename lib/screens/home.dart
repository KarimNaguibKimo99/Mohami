import 'package:flutter/material.dart';
import 'package:user/chat/chat.dart';
import 'package:user/notification/notification.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/blur.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white.withOpacity(0.3),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.3),
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        'الرئيسية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                  alignment: Alignment.topCenter,
                  height: 180,
                  width: 200,
                  child: Image.asset(
                    'images/mohami.png',
                    width: 220,
                    height: 220.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
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
                          onPressed: () {}),
                      Text(
                        'الاتصال',
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
