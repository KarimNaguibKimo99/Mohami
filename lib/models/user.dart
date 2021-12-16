import 'package:flutter/material.dart';

class User {
  final String id;
  final String username;
  final String password;
  final String mobile;
  User({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.mobile,
  });

  User.fromjson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        mobile = json['mobile'];
}
