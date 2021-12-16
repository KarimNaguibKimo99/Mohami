import 'package:dio/dio.dart';
import 'package:el_mohami/components/rounded_button.dart';
import 'package:el_mohami/models/customer.dart';
import 'package:el_mohami/models/customer_response.dart';
import 'package:el_mohami/new%20file/infromation/date.dart';
import 'package:el_mohami/new%20file/infromation/edit_information.dart';
import 'package:el_mohami/new%20file/infromation/form.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:el_mohami/bloc/customer_bloc.dart';

class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  String searchValue;
  @override
  void initState() {
    super.initState();
    searchValue = '';
    customerBloc.getCustomer();
  }

  Future<void> _deleteDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atention'),
          content: Text(
            'تاكيد الحذف',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                try {
                  FormData formData = new FormData.fromMap({
                    'id': customers[index].id,
                  });
                  var response = await _dio.post(
                      'https://tawaklsa.com/moham/delete_client.php',
                      data: formData);
                  if (response.statusCode == 200) {
                    setState(() {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SearchCustomer();
                        },
                      ));
                    });
                  }
                } on DioError catch (e) {
                  if (e.response.statusCode == 400) {
                    print(e.response.statusCode);
                    setState(() {
                      _showMyDialog('حدث خطأ حاول مجددا');
                    });
                  } else {
                    setState(() {
                      _showMyDialog('حدث خطأ حاول مجددا');
                    });
                  }
                }
              },
            ),
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Atention'),
          content: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;
  final nameSelected = TextEditingController();
  List<String> customersNames = [];
  List<Customer> customers = [];
  String selectedName = "";
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: customerBloc.subject.stream,
      builder: (context, AsyncSnapshot<CustomerResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return Scaffold(
              body: Container(
                child: Center(child: Text('لا يوجد عملاء')),
              ),
            );
            //return _buildErrorWidget(snapshot.data.error);
          } else {
            return _buildUserWidget(snapshot.data);
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Center(child: Text('لا يوجد عملاء')),
            ),
          );
          //return _buildErrorWidget(snapshot.data.error);
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
          //return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildUserWidget(CustomerResponse data) {
    /* customers = data.results; */
    return Scaffold(
      appBar: AppBar(
        title: Text('البحث عن العميل'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
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
            child: Column(children: [
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
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  child: TextFormField(
                    maxLength: null,
                    maxLines: null,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        searchValue = value;
                        customersNames = [];
                        /* if (searchValue == '') {
                          customers = data.results;
                          print(customers.length);
                        } else { */
                        customers = data.results.where((element) {
                          return element.name.contains(searchValue);
                        }).toList();
                        print('customers length 2 ${customers.length}');
                        /* } */
                        for (int i = 0; i < customers.length; i++) {
                          customersNames.add(customers[i].name);
                          print('customersNames length 3 ${customersNames[i]}');
                        }
                        print('customers = ${customers.length}');
                        print(
                            'customersNames length = ${customersNames.length}');
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "بحث باسم العميل",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                      ),
                    ),
                  ),
                ),
              ),
              /* Container(
                height: 200,
                width: 250,
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    print('customers length1 ${customers.length}');
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Dat(customer: customers[index]),
                            ),
                          );
                        },
                        child: Text(
                          customers[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ) */
              searchValue != ''
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          print('custmers length 6 ${customers.length}');

                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Dat(customer: customers[index]),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      /* onTap: () async {
                                        try {
                                          FormData formData =
                                              new FormData.fromMap({
                                            'id': customers[index].id,
                                          });
                                          var response = await _dio.post(
                                              'https://tawaklsa.com/moham/client.php',
                                              data: formData);
                                          if (response.statusCode == 200) {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return EditInformation(
                                                    username: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['username'],
                                                    password: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['password'],
                                                    email: response.data.values
                                                        .toList()[0]['email'],
                                                    location: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['location'],
                                                    mobile: response.data.values
                                                        .toList()[0]['mobile'],
                                                    mobileAlt: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['mobile_alt'],
                                                    caseTitle: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['case_title'],
                                                  );
                                                },
                                              ));
                                            });
                                          }
                                        } on DioError catch (e) {
                                          if (e.response.statusCode == 400) {
                                            print(e.response.statusCode);
                                            setState(() {
                                              _showMyDialog(
                                                  'حدث خطأ حاول مجددا');
                                            });
                                          } else {
                                            setState(() {
                                              _showMyDialog(
                                                  'حدث خطأ حاول مجددا');
                                            });
                                          }
                                        }
                                      }, */
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _deleteDialog(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      customers[index].name,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          print('custmers length 6 ${customers.length}');

                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Dat(customer: customers[index]),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      /* onTap: () async {
                                        try {
                                          FormData formData =
                                              new FormData.fromMap({
                                            'id': customers[index].id,
                                          });
                                          var response = await _dio.post(
                                              'https://tawaklsa.com/moham/client.php',
                                              data: formData);
                                          if (response.statusCode == 200) {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return EditInformation(
                                                    username: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['username'],
                                                    password: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['password'],
                                                    email: response.data.values
                                                        .toList()[0]['email'],
                                                    location: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['location'],
                                                    mobile: response.data.values
                                                        .toList()[0]['mobile'],
                                                    mobileAlt: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['mobile_alt'],
                                                    caseTitle: response
                                                            .data.values
                                                            .toList()[0]
                                                        ['case_title'],
                                                  );
                                                },
                                              ));
                                            });
                                          }
                                        } on DioError catch (e) {
                                          if (e.response.statusCode == 400) {
                                            print(e.response.statusCode);
                                            setState(() {
                                              _showMyDialog(
                                                  'حدث خطأ حاول مجددا');
                                            });
                                          } else {
                                            setState(() {
                                              _showMyDialog(
                                                  'حدث خطأ حاول مجددا');
                                            });
                                          }
                                        }
                                      }, */
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _deleteDialog(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      customers[index].name,
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ]),
          ),
        ],
      ),
    );
  }
}
