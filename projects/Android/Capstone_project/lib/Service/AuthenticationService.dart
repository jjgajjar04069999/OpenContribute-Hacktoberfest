import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/DatabaseManager/DatabaseManager.dart';
import 'package:flutter_login_signup/Service/preference.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _error;

  Future<String?> getCurrentUID() async {
    User? user = (_auth.currentUser);
    return user != null ? user.uid : null;
  }

  Future createNewUser(String name, String rollNumber, String email,
      String password, String pin, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      preferenceHelper.login(true);
      preferenceHelper.preferences.setString('uid', result.user!.uid);
      preferenceHelper.preferences.setString('rollno', rollNumber);
      preferenceHelper.preferences.setString('email', email);
      preferenceHelper.preferences.setString('name', name);
      await DatabaseManager()
          .createUserData(email, name, rollNumber, user!.uid, pin);

      return user;
    } catch (e) {
      _error = e.toString();

      print(e.toString());
      print(_error);
    }
  }

  Future<List> addMoney(String uid, String money) async {
    String total = '0';
    List trans = [];
    await _firestore.collection('profile').doc(uid).get().then((value) {
      trans = value.get('transaction');
      total = value.get('money');
    });
    int add = int.parse(total) + int.parse(money);
    await _firestore
        .collection('profile')
        .doc(uid)
        .update({'money': add.toString()});
    return [add.toString(), trans];
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      DatabaseManager databaseManager = DatabaseManager(uid: result.user!.uid);
      DocumentSnapshot resultant = await databaseManager.getUsersList();
      preferenceHelper.login(true);
      preferenceHelper.preferences.setString('uid', result.user!.uid);
      preferenceHelper.preferences.setString('rollno', resultant.get('rollNo'));
      preferenceHelper.preferences.setString('email', email);
      preferenceHelper.preferences.setString('name', resultant.get('name'));
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      preferenceHelper.login(false);
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  void _showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
