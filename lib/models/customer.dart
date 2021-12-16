import 'package:flutter/material.dart';

class Customer {
  final String id;
  final String name;
  final String phone;
  final String altPhone;
  final String email;
  final String address;
  final String caseTitle;
  Customer({
    @required this.id,
    @required this.name,
    @required this.phone,
    this.altPhone,
    @required this.email,
    @required this.address,
    @required this.caseTitle,
  });

  Customer.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['username'],
        phone = json['mobile'],
        altPhone = json['mobile_alt'],
        email = json['email'],
        address = json['address'],
        caseTitle = json['case_title'];
}
