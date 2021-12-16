import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Elmohami {
  static const String appName = 'El Mohami';

  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore fireStore;

  static String collectionCustomer = "customers";
  static String collectionUser = "users";

  static final String userName = "name";
  static final String userEmail = "email";
  static final String userUID = "uid";
  static final String phoneNumber = "phoneNumber";
  static final String gender = "gender";
  static final String userAvatarUrl = "userAvatarUrl";
  static final String userMobile = "userMobile";
  static final String staySigned = "staySigned";
  static final String isAdmin = "isAdmin";

  static final String customersCount = "customerCount";

  static final String customersNames = "customerNames";
  static final String customersphones = "customerPhones";
  static final String customersAddresses = "customerAddresses";
  static final String customersIDs = "customerIDs";

  static final String customerID = "id";
  static final String customerAddress = "address";
  static final String customerName = "name";
  static final String customerPhoneNumber = "phoneNumber";
  static final String customerDate = "customerDate";
}
