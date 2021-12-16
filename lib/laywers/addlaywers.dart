import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/laywers/form2.dart';
import 'package:flutter/material.dart';

class Laywers extends StatefulWidget {
  @override
  _LaywersState createState() => _LaywersState();
}

class _LaywersState extends State<Laywers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محامين وموظفين'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /*  Image.asset(
              'images/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ), */
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 280.0,
                    height: 240.0,
                    child: Image.asset('images/mohami.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: RoundedButton(
                    title: 'الإضافة ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (Laywer())));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      children: [
                        TableRow(children: [
                          Container(
                            color: Colors.blueGrey,
                            child: Column(children: [
                              Text('العنوان',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black))
                            ]),
                          ),
                          Container(
                            color: Colors.blueGrey,
                            child: Column(children: [
                              Text('القضية',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black))
                            ]),
                          ),
                          Container(
                            color: Colors.blueGrey,
                            child: Column(children: [
                              Text('الاسم',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black))
                            ]),
                          ),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text(
                              'المحلة',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'جنائى',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'احمد عادل ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text(
                              'المحلة',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'جنائى',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'احمد عادل ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text(
                              'المحلة',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'جنائى',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'احمد عادل ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text(
                              'المحلة',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'جنائى',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            )
                          ]),
                          Column(children: [
                            Text(
                              'احمد عادل ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ]),
                        ]),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
