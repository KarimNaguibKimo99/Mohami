import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/infromation/form.dart';
import 'package:el_mohami/new%20file/login.dart';
import 'package:flutter/material.dart';

class Thanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'images/chat.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'تم إضافة العميل بنجاح',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  RoundedButton(
                    title: 'الرئيسية',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LLogin()));
                    },
                  ),
                  RoundedButton(
                    title: 'عميل جديد ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Information()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
