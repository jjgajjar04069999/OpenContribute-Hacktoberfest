import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_signup/Service/preference.dart';

class DatabaseManager {
  final String? uid;

  DatabaseManager({this.uid});

  final profile = FirebaseFirestore.instance.collection('profile');
  final chatRoom = FirebaseFirestore.instance.collection('chatRoom');

  Future createUserData(String email, String name, String rollNumber,
      String uid, String pin) async {
    return await profile.doc(uid).set({
      'userEmail': email,
      'name': name,
      'rollNo': rollNumber,
      'money': '0',
      'pin': pin,
      'feed': [],
      'transaction': []
    });
  }
  Future updateUserList(
      String name, String rollNumber, String money, String uid) async {
    return await profile
        .doc(uid)
        .update({'name': name, 'rollNo': rollNumber, 'money': money});
  }

  Future updateProfile(String name, String rollNumber, String uid) async {
    preferenceHelper.preferences.setString('name', name);
    preferenceHelper.preferences.setString('rollno', rollNumber);
    return await profile.doc(uid).update({
      'name': name,
      'rollNo': rollNumber,
    });
  }

  Future getUsersList() async {
    try {
      DocumentSnapshot itemsList = await profile.doc(uid).get();
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
