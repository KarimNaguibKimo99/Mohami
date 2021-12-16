import 'package:flutter/material.dart';

class Gadwal extends StatefulWidget {
  @override
  _GadwalState createState() => _GadwalState();
}

class _GadwalState extends State<Gadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('بيانات العميل'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Table(
                defaultColumnWidth: FixedColumnWidth(130.0),
                border: TableBorder.all(
                    color: Colors.indigo, style: BorderStyle.solid, width: 2),
                children: [
                  TableRow(
                    children: [
                      Column(children: [
                        Text('ملف القضية',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ))
                      ]),
                      Column(children: [
                        Text('رقم القضية ',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black))
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم العميل',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
