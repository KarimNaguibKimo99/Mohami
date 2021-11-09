import 'package:flutter/material.dart';
import 'package:user/notification/notedetails.dart';
import 'package:user/screens/home.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
        ),
      ),
    );
  }
}
