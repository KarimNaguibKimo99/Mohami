import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/pages/form1.dart';
import 'package:el_mohami/services/customers_data.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';

class Coustomer extends StatefulWidget {
  static String routeName = '/customer';
  @override
  _CoustomerState createState() => _CoustomerState();
}

class _CoustomerState extends State<Coustomer> {
  final CustomersData customerData = CustomersData();
  int length = 0;
  Map<String, List<String>> customersData = {
    Elmohami.customerAddress: [],
    Elmohami.customerPhoneNumber: [],
    Elmohami.customerName: [],
    Elmohami.customerID: [],
  };
  @override
  void initState() {
    super.initState();
  }

  /* getMethod() {
    FirebaseFirestore.instance
        .collection(Elmohami.collectionCustomer)
        .get()
        .then((value) {
      value.docs.any((element) {
        if (element.get(Elmohami.phoneNumber) == '') {
          return true;
        }
        return false;
      });
      length = value.size;
      print(length);
    }).then(
      (value) {
        for (int j = 0; j < 4; j++) {
          for (int i = 0; i < length; i++) {
            FirebaseFirestore.instance
                .collection(Elmohami.collectionCustomer)
                .get()
                .then(
              (value) {
                customersData.values.toList()[j].add(
                      value.docs[i].get(
                        customersData.keys.toList()[j],
                      ),
                    );
              },
            );
          }
        }
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عملاء'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(Elmohami.collectionCustomer)
            .orderBy(Elmohami.customerDate, descending: true)
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
            length = snapshot.data.docs.length;
            for (int j = 0; j < 4; j++) {
              for (int i = 0; i < length; i++) {
                customersData.values.toList()[j].add(snapshot.data.docs
                    .elementAt(i)
                    .get(customersData.keys.toList()[j]));
              }
            }
            return SingleChildScrollView(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Employee(),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          width: constraints.maxWidth / 4,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              border: Border(
                                                left: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0,
                                                ),
                                                top: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0,
                                                ),
                                              )),
                                          child: Column(
                                            children: [
                                              Text(
                                                'العنوان',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: constraints.maxWidth / 4,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              top: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'الرقم',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: constraints.maxWidth / 4,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              top: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'الاسم',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: constraints.maxWidth / 4,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              top: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              right: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                'رقم الكود',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    length == 0 ||
                                            customersData.values
                                                .toList()[0]
                                                .isEmpty ||
                                            customersData.values
                                                .toList()[1]
                                                .isEmpty ||
                                            customersData.values
                                                .toList()[2]
                                                .isEmpty ||
                                            customersData.values
                                                .toList()[3]
                                                .isEmpty
                                        ? Center(
                                            child: Text('Add data'),
                                          )
                                        : Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          customersData.values
                                                                  .toList()[0]
                                                              [index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          customersData.values
                                                                  .toList()[1]
                                                              [index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          customersData.values
                                                                  .toList()[2]
                                                              [index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                          bottom: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                          right: BorderSide(
                                                            color: Colors.black,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          customersData.values
                                                                  .toList()[3]
                                                              [index],
                                                          style: TextStyle(
                                                            fontSize: 10.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
