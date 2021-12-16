import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './el_mohami.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

//import '../models/user.dart';

class AuthService {
  //bool _signedWithGoogle = false;
  //final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // create user obj based on firebase user
  /* User _userFromFirebaseUser(auth.User user) {
    return user != null ? User(uid: user.uid) : null;
  } */

  // auth change user stream
  Stream<auth.User> get user {
    return Elmohami.auth.authStateChanges();
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    auth.User firebaseUser;
    await Elmohami.auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((auth) {
      firebaseUser = auth.user;
      if (firebaseUser != null) {
        _readData(firebaseUser);
      }
    }).catchError((error) {
      throw error;
    });
  }
  /* Future signInWithEmailAndPassword(String email, String password) async {
    auth.User firebaseUser;
    await Elmohami.auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((auth) {
      firebaseUser = auth.user;
      if (firebaseUser != null) {
        _readData(firebaseUser);
      }
    }).catchError((error) {
      throw error;
    });
  } */

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String name, String phoneNumber, String gender) async {
    auth.User firebaseUser;
    await Elmohami.auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((auth) {
      firebaseUser = auth.user;
      if (firebaseUser != null) {
        _saveUserInfoToFirestore(firebaseUser, name, phoneNumber, gender);
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future _saveUserInfoToFirestore(
    auth.User fUser,
    String name,
    String phoneNumber,
    String gender,
  ) async {
    FirebaseFirestore.instance
        .collection(Elmohami.collectionUser)
        .doc(fUser.uid)
        .set({
      Elmohami.userUID: fUser.uid,
      Elmohami.userEmail: fUser.email,
      Elmohami.userName: name,
      Elmohami.phoneNumber: phoneNumber,
      Elmohami.gender: gender,
      Elmohami.userAvatarUrl: '',
    });

    await Elmohami.sharedPreferences.setString(Elmohami.userUID, fUser.uid);
    print('saveUserInfoToFirestore userUID setted ${fUser.uid}');
    await Elmohami.sharedPreferences.setString(Elmohami.userEmail, fUser.email);
    print('saveUserInfoToFirestore userEmail setted ${fUser.email}');
    await Elmohami.sharedPreferences.setString(Elmohami.userName, name);
    print('saveUserInfoToFirestore userDisplayName setted $name');
    await Elmohami.sharedPreferences
        .setString(Elmohami.phoneNumber, phoneNumber);
    print('saveUserInfoToFirestore user phone number setted $phoneNumber');
    await Elmohami.sharedPreferences.setString(Elmohami.gender, gender);
    print('saveUserInfoToFirestore user gender setted $gender');
    await Elmohami.sharedPreferences.setString(Elmohami.userAvatarUrl, '');
    print('saveUserInfoToFirestore user photo setted empty');
  }

  Future _readData(auth.User fUser) async {
    FirebaseFirestore.instance
        .collection(Elmohami.collectionUser)
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await Elmohami.sharedPreferences
          .setString(Elmohami.userUID, dataSnapshot.data()[Elmohami.userUID]);
      print('readData userUID setted');
      await Elmohami.sharedPreferences.setString(
          Elmohami.userEmail, dataSnapshot.data()[Elmohami.userEmail]);
      print('readData user Email setted');
      await Elmohami.sharedPreferences
          .setString(Elmohami.userName, dataSnapshot.data()[Elmohami.userName]);
      print('readData user Name setted');
      await Elmohami.sharedPreferences.setString(
          Elmohami.phoneNumber, dataSnapshot.data()[Elmohami.phoneNumber]);
      print('readData user Phone number setted');
      await Elmohami.sharedPreferences
          .setString(Elmohami.gender, dataSnapshot.data()[Elmohami.gender]);
      print('readData user gender setted');
      await Elmohami.sharedPreferences.setString(Elmohami.userAvatarUrl, '');
      print('readData user gender setted');
    });
  }

  Future _googleReadData(auth.User fUser) async {
    FirebaseFirestore.instance
        .collection(Elmohami.collectionUser)
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await Elmohami.sharedPreferences
          .setString(Elmohami.userUID, dataSnapshot.data()[Elmohami.userUID]);
      print('readData userUID setted');
      await Elmohami.sharedPreferences.setString(
          Elmohami.userEmail, dataSnapshot.data()[Elmohami.userEmail]);
      print('readData user Email setted');
      await Elmohami.sharedPreferences
          .setString(Elmohami.userName, dataSnapshot.data()[Elmohami.userName]);
      print('readData user Name setted');
      await Elmohami.sharedPreferences.setString(Elmohami.gender, '');
      print('readData user gender setted');
      await Elmohami.sharedPreferences.setString(
          Elmohami.userAvatarUrl, dataSnapshot.data()[Elmohami.userAvatarUrl]);
      print('readData user photo setted');
      /* await Elmohami.sharedPreferences.setString(
          Elmohami.phoneNumber, dataSnapshot.data()[Elmohami.phoneNumber]);
      print('readData user Phone number setted');
      await Elmohami.sharedPreferences
          .setString(Elmohami.gender, dataSnapshot.data()[Elmohami.gender]);
      print('readData user gender setted'); */
    });
  }

  Future _removeUserSharedData() async {
    await Elmohami.sharedPreferences.setString(Elmohami.userUID, '');
    print('deleteUserInfoToFirestore userUID empty');
    await Elmohami.sharedPreferences.setString(Elmohami.userEmail, '');
    print('deleteUserInfoToFirestore userEmail  empty');
    await Elmohami.sharedPreferences.setString(Elmohami.userName, '');
    print('deleteUserInfoToFirestore userDisplayName  empty');
    await Elmohami.sharedPreferences.setString(Elmohami.phoneNumber, '');
    print('deleteUserInfoToFirestore user phone number  empty');
    await Elmohami.sharedPreferences.setString(Elmohami.gender, '');
    print('deleteUserInfoToFirestore user gender  empty');
    await Elmohami.sharedPreferences.setString(Elmohami.userAvatarUrl, '');
    print('deleteUserInfoToFirestore user avatar url  empty');
  }

  // sign out
  Future signOut() async {
    try {
      print('================================= signed out');
      await _removeUserSharedData();
      return await Elmohami.auth.signOut();
    } catch (error) {
      throw error;
    }
  }

  // update password
  Future updatePassword(String password) async {
    try {
      print('================================= password updated');
      return await Elmohami.auth.currentUser.updatePassword(password);
    } catch (error) {
      throw error;
    }
  }

  // validate user
  Future<bool> validateUser(String password) async {
    try {
      var firebaseUser = Elmohami.auth.currentUser;
      var authCredentials = auth.EmailAuthProvider.credential(
          email: Elmohami.sharedPreferences.get(Elmohami.userEmail),
          password: password);
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      return false;
    }
  }

  /* // sms code
  Future<void> smsVerfiyCode(String phoneNo, Navigator page) async {
    final auth.PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};
    final auth.PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) {
      page;
    };
    final auth.PhoneVerificationCompleted verifiedSuccess =
        (auth.AuthCredential auth) {};
    final auth.PhoneVerificationFailed verifyFailed =
        (auth.FirebaseAuthException e) {
      print('${e.message}');
    };
    await auth.FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  } */
  // sign in with Google
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<auth.UserCredential> signInWithGoogle() async {
    auth.User firebaseUser;
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    return await Elmohami.auth.signInWithCredential(credential).then((auth) {
      firebaseUser = auth.user;
      if (firebaseUser != null) {
        if (auth.additionalUserInfo.isNewUser) {
          print('new user');
          saveGoogleUserInfoToFirestore(firebaseUser);
        } else {
          print('old user');
          _googleReadData(auth.user);
        }
      }
    }).catchError((error) {
      print('there is an error => $error');
      throw error;
    });
    /* print('User Name : ${MegaStore.userName}');
    //_signedWithGoogle = true;
    //return _userFromFirebaseUser(user);
    return user; */
  }

  Future saveGoogleUserInfoToFirestore(auth.User fUser) async {
    FirebaseFirestore.instance
        .collection(Elmohami.collectionUser)
        .doc(fUser.uid)
        .set({
      Elmohami.userUID: fUser.uid,
      Elmohami.userEmail: fUser.email,
      Elmohami.userName: fUser.displayName,
      Elmohami.gender: '',
      Elmohami.userAvatarUrl: fUser.photoURL,
    });

    await Elmohami.sharedPreferences.setString(Elmohami.userUID, fUser.uid);
    print('saveGoogleUserInfoToFirestore userUID setted');
    await Elmohami.sharedPreferences.setString(Elmohami.userEmail, fUser.email);
    print('saveGoogleUserInfoToFirestore userEmail setted');
    await Elmohami.sharedPreferences
        .setString(Elmohami.userName, fUser.displayName);
    print('saveGoogleUserInfoToFirestore userDisplayName setted');
    await Elmohami.sharedPreferences
        .setString(Elmohami.userAvatarUrl, fUser.photoURL);
    print('saveGoogleUserInfoToFirestore userPhotoURL setted');
  }

  // facebook login
  FacebookLogin _facebookLogin = FacebookLogin();

  Future signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    FacebookLoginResult _result = await _facebookLogin.logIn(['email']);
    switch (_result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print('cancelledByUser');
        break;
      case FacebookLoginStatus.error:
        print('${_result.errorMessage}');
        break;
      case FacebookLoginStatus.loggedIn:
        await _loginWithFacebook(_result);
        break;
    }
  }

  Future _loginWithFacebook(FacebookLoginResult result) async {
    auth.User firebaseUser;
    FacebookAccessToken facebookAccessToken = result.accessToken;
    auth.AuthCredential _credential =
        auth.FacebookAuthProvider.credential(facebookAccessToken.token);

    await Elmohami.auth.signInWithCredential(_credential).then((auth) {
      firebaseUser = auth.user;
      if (firebaseUser != null) {
        String photoUrl = firebaseUser.photoURL +
            "?height=500&access_token=" +
            facebookAccessToken.token;
        firebaseUser.updateProfile(photoURL: photoUrl);
        if (auth.additionalUserInfo.isNewUser) {
          print('new user');
          saveGoogleUserInfoToFirestore(firebaseUser);
        } else {
          print('old user');
          _googleReadData(auth.user);
        }
      }
    }).catchError((error) {
      print('there is an error => $error');
      throw error;
    });
  }
}
