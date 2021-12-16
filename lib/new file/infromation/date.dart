import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/meeting/office.dart';
import 'package:el_mohami/new%20file/meeting/session.dart';
import 'package:flutter/material.dart';
import 'package:el_mohami/models/customer.dart';

class Dat extends StatefulWidget {
  final Customer customer;
  Dat({@required this.customer});
  @override
  _DatState createState() => _DatState();
}

class _DatState extends State<Dat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(" اختيار نوع المقابلة مع العميل"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/6.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'images/mohami.png',
                    width: 220,
                    height: 220.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: RoundedButton(
                    title: 'ميعاد الجلسة ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Session(
                            customer: widget.customer,
                            title: 'تفاصيل الجلسة ',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                RoundedButton(
                  title: 'موعد خاص بالمكتب',
                  colour: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Session(
                          customer: widget.customer,
                          title: 'تفاصيل الاجتماع مع العميل ',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
