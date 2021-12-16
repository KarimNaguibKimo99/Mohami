import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/addcoustomer.dart';
import 'package:el_mohami/services/auth.dart';
import 'package:el_mohami/services/customers_data.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class Employee extends StatefulWidget {
  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final AuthService auth = AuthService();
  final CustomersData customersData = CustomersData();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _idTextController = TextEditingController();
  bool alreadyExist = true;
  @override
  Widget build(BuildContext context) {
    _showMyDialog() {
      return showDialog(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atention'),
            content: Text(
              'Unsuccessful addition',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  alreadyExist = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('إدخال بيانات عملاء'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _nameTextController,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Enter Valid Name';
                                else
                                  return null;
                              },
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: 'الاسم بالكامل',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                /* Pattern pattern = r'^(?:[+0][1-9])?[0]{10}$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Enter Valid Phone Number';
                                else
                                  return null; */
                              },
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'رقم الموبايل',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _addressTextController,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Enter Valid Name';
                                else
                                  return null;
                              },
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'العنوان',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _idTextController,
                              validator: (value) {
                                if (value.isEmpty || value.length != 14)
                                  return 'Enter Valid Name';
                                else
                                  return null;
                              },
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'رقم البطاقة / جواز السفر',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  RoundedButton(
                    title: 'تأكيد ',
                    colour: Colors.blueGrey,
                    onPressed: () async {
                      try {
                        if (_formKey.currentState.validate()) {
                          FirebaseFirestore.instance
                              .collection(Elmohami.collectionCustomer)
                              .get()
                              .then((value) {
                            for (int i = 0; i < value.size; i++) {
                              if (value.docs[i].get(Elmohami.customerID) !=
                                  _idTextController.text) {
                                if (value.docs[i]
                                        .get(Elmohami.customerPhoneNumber) ==
                                    _phoneTextController.text) {
                                  print('repeated phone');
                                  alreadyExist = false;
                                }
                              } else {
                                print('repeated id');
                                alreadyExist = false;
                              }
                            }
                          }).then((value) {
                            if (alreadyExist) {
                              print('repeated id and phone');
                              FirebaseFirestore.instance
                                  .collection(Elmohami.collectionCustomer)
                                  .doc(_idTextController.text)
                                  .set({
                                Elmohami.customerID: _idTextController.text,
                                Elmohami.customerAddress:
                                    _addressTextController.text,
                                Elmohami.customerName: _nameTextController.text,
                                Elmohami.customerPhoneNumber:
                                    _phoneTextController.text,
                                Elmohami.customerDate:
                                    DateTime.now().toIso8601String(),
                              }).then((value) {
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushReplacementNamed(Coustomer.routeName);
                              });
                            } else {
                              setState(() {
                                _showMyDialog();
                              });
                            }
                          });
                        }
                      } catch (e) {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
