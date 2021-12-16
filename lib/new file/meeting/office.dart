/* import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/new%20file/Chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class Office extends StatefulWidget {
  @override
  _OfficeState createState() => _OfficeState();
}

class _OfficeState extends State<Office> {
  TextEditingController _dateTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate;
  String selectedTime;

  Future<Null> _selectedTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime =
        localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);
    if (formattedTime != null)
      setState(() {
        selectedTime = formattedTime;
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    //if (picked != null)
    setState(() {
      selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الجلسة '),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/5.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: Form(
                key: _formKey,
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
                    Container(
                      height: 80,
                      width: 250,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (selectedDate != null) {
                            return null;
                          } else {
                            return 'اختر التاريخ';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: selectedDate == null
                              ? 'التاريخ'
                              : DateFormat.yMMMMd().format(selectedDate),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                        ),
                        enabled: false,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectDate(context);
                          /* await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 20),
                          ); */
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        width: 250,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          controller: _dateTextController,
                          validator: (value) {
                            if (value.isNotEmpty && isNumeric(value)) {
                              if (int.parse(value.toString()) > 24 ||
                                  int.parse(value.toString()) < 0)
                                return 'ادخل وقت صحيح';
                              else
                                return null;
                            } else {
                              return 'ادخل وقت صحيح';
                            }
                          },
                          enabled: false,
                          onTap: () {
                            _selectedTime(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'الوقت',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        width: 250,
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'المكان',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Container(
                          width: 130,
                          child: RoundedButton(
                            title: 'الإتصال',
                            colour: Colors.blueGrey,
                            onPressed: () {
                              //  Navigator.push(context,
                              //  MaterialPageRoute(builder: (context) => Chat()));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          width: 130,
                          child: RoundedButton(
                            title: 'الشات',
                            colour: Colors.blueGrey,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat()));
                            },
                          ),
                        ),
                      ),
                    ]),
                    RoundedButton(
                      title: 'ارسال التفاصيل',
                      colour: Colors.blueGrey,
                      onPressed: () {
                        if (selectedDate != null &&
                            _formKey.currentState.validate()) {}
                        //  Navigator.push(context,
                        //  MaterialPageRoute(builder: (context) => Chat()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */