import 'package:flutter/material.dart';
import 'package:user/screens/home.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'images/3.png',
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
                          'الشات',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 700.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  height: 40,
                  child: TextField(
                    maxLines: 100,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                        hintText: 'اكتب رسالتك',
                        hintStyle: TextStyle(color: Colors.black)),
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
