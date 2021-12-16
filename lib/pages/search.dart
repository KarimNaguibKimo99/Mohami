import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/check.dart';
import 'package:el_mohami/pages/forget.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SearchMobile extends StatefulWidget {
  @override
  _SearchMobileState createState() => _SearchMobileState();
}

class _SearchMobileState extends State<SearchMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جد حسابك'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'images/4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اكتب الرقم',
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: kTextFiledDecoration.copyWith(
                        isDense: true,
                        hintText: 'الرقم',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedButton(
                    title: 'تاكيد ',
                    colour: Colors.blueGrey,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Code()));
                    },
                  ),
                ),
                RoundedButton(
                  title: 'البحث بواسطة الايميل ',
                  colour: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/check.dart';
import 'package:el_mohami/pages/forget.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../constants.dart';

class SearchMobile extends StatefulWidget {
  @override
  _SearchMobileState createState() => _SearchMobileState();
}

class _SearchMobileState extends State<SearchMobile> {
  TextEditingController _phoneTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جد حسابك'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Elmohami.collectionCustomer)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Error Occured'),
              ),
            );
          } else if (snapshot.data == null) {
            return CircularProgressIndicator();
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        Text(
                          'اكتب الرقم',
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextFormField(
                            controller: _phoneTextController,
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length != 11 ||
                                  !isNumeric(value) ||
                                  !value.startsWith('01')) {
                                return 'Enter valid phone number';
                              } else {
                                return null;
                              }
                            },
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              //Do something with the user input.
                            },
                            decoration: kTextFiledDecoration.copyWith(
                                isDense: true,
                                hintText: 'الرقم',
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 150.0),
                                child: RoundedButton(
                                  title: 'تأكيد ',
                                  colour: Colors.blueGrey,
                                  onPressed: () async {
                                    /* snapshot.data.docs.where((element) {
                                        if (element.get(Elmohami.phoneNumber) ==
                                            _phoneTextController.text) {
                                          //return true;
                                        }
                                        //return false;
                                      }) any((element) ); */
                                    /* await FirebaseFirestore.instance
                                        .collection(Elmohami.collectionCustomer)
                                        .get()
                                        .then((value) {
                                      value.docs.any((element) {
                                        if (element.get(Elmohami.phoneNumber) ==
                                            _phoneTextController.text) {
                                          return true;
                                        }
                                        return false;
                                      });
                                    }); */
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Code()));
                                  },
                                ),
                              ),
                              RoundedButton(
                                title: 'البحث بواسطة الايميل ',
                                colour: Colors.blueGrey,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPassword()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
 */
