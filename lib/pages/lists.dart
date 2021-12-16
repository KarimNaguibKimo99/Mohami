import 'package:el_mohami/laywers/addlaywers.dart';
import 'package:el_mohami/pages/addcoustomer.dart';
import 'package:el_mohami/pages/change_password.dart';
import 'package:el_mohami/pages/login.dart';
import 'package:el_mohami/services/auth.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Lis extends StatefulWidget {
  @override
  _LisState createState() => _LisState();
}

class _LisState extends State<Lis> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        /* title: Row(
          children: [
            /* PopupMenuButton(
                /* icon: CircleAvatar(
                  backgroundColor: Colors.grey,
                ), */
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
                            await auth.signOut().then(
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
                    ]), */
            /* IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: FirebaseAuth.instance.currentUser.photoURL != null
                      ? ClipRRect(
                          child: Image.network(
                              FirebaseAuth.instance.currentUser.photoURL),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        )
                      : Container(),
                ),
                onPressed: () {
                  _openEndDrawer();
                  /* ListTile(
                    title: Text('Home Page'),
                    leading: Icon(Icons.home, color: Colors.indigo),
                  ); */
                }), */
            SizedBox(
              width: 10.0,
            ),
            IconButton(icon: Icon(Icons.crop_free), onPressed: () {}),
            SizedBox(
              width: 60.0,
            ),
            Text('الرئيسية ')
          ],
        ), */
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.blue[900],
          child: new ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: FirebaseAuth.instance.currentUser.photoURL != null
                      ? ClipRRect(
                          child: Image.network(
                              FirebaseAuth.instance.currentUser.photoURL),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        )
                      : Container(),
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
                onTap: () async {
                  await auth.signOut().then(
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
                        child: Icon(Icons.logout, color: Colors.indigo[300]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          /* Image.asset(
            'images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ), */
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: Container(
              alignment: Alignment.topCenter,
              width: 280.0,
              height: 240.0,
              child: Image.asset('images/mohami.png'),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0, left: 8.0, right: 8.0),
              child: Center(
                child: Container(
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Laywers()));
                          },
                          child: Text('محامين وموظفين',
                              style: TextStyle(fontSize: 15.0)),
                          color: Colors.blueGrey[300],
                        ),
                        (MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Coustomer()));
                          },
                          child:
                              Text('عملاء', style: TextStyle(fontSize: 15.0)),
                          color: Color(0xFF103442),
                        )),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'عمل ادارئ',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          color: Color(0xFF103442),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: Text(
                            'جلسات',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          color: Colors.blueGrey[300],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
