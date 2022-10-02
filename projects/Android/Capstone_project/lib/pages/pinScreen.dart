import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/chats.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PinScreen extends StatefulWidget {
  final data;

  PinScreen(this.data);

  @override
  State<PinScreen> createState() => _PinScreenState(this.data);
}

class _PinScreenState extends State<PinScreen> {
  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _PinScreenState(data);

  bool visible = false;
  String? userPin;
  String? userUID;
  String? userName;

  getPin() {
    _firestore
        .collection('profile')
        .where('rollNo', isEqualTo: widget.data['uid'])
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        Fluttertoast.showToast(msg: 'Invalid User');
      } else {
        userUID = value.docs[0].id;
        userPin = value.docs[0].get('pin');
        userName = value.docs[0].get('name');
      }
    });
  }

  sendMoney(ctx) async {
    setState(() {
      visible = true;
    });
    String? uid = preferenceHelper.preferences.getString('uid');
    String? rollno = preferenceHelper.preferences.getString('rollno');
    String money = '';
    await _firestore
        .collection('profile')
        .doc(userUID)
        .get()
        .then((value) => money = value.get('money'));
    print('step money +++++ $money');
    print('step money +++++ ${widget.data['money']}');
    if (double.parse(money) < double.parse(widget.data['money'].toString())) {
      return Fluttertoast.showToast(msg: 'Money is insufficient in wallet');
    }
    String? name = preferenceHelper.preferences.getString('name');

    money =
        '${double.parse(money) - double.parse(widget.data['money'].toString())}';
    await _firestore.collection('profile').doc(userUID).update({
      'money': money,
      'transaction': FieldValue.arrayUnion([
        {
          'uid': uid,
          'money': widget.data['money'],
          'send': true,
          'time': DateTime.now(),
          'rollNo': widget.data['uid'],
          'name': name,
        }
      ])
    });
    var userMoney;
    await _firestore
        .collection('profile')
        .doc(uid)
        .get()
        .then((value) => userMoney = value.get('money'));
    userMoney =
        '${double.parse(money) - double.parse(widget.data['money'].toString())}';
    await _firestore.collection('profile').doc(uid).update({
      'money': userMoney,
      'transaction': FieldValue.arrayUnion([
        {
          'uid': userUID,
          'money': widget.data['money'],
          'send': false,
          'time': DateTime.now(),
          'rollNo': widget.data['uid'],
          'name': userName
        }
      ])
    });

    var room = _firestore.collection('chatRoom').get();
    List users;
    bool found = false;
    String chatRoom = '';
    room.then((value) => {
          value.docs.forEach((element) {
            users = element.id.split('-');
            if (users.contains(widget.data['uid']) && users.contains(rollno)) {
              print('enter in chatRom++++++++++++++++++++++++++++++++++++++++');
              found = true;
              sendMessage(element.id, uid);
              return;
            }
          }),
          if (!found)
            {
              createRoom(
                  rollno: rollno,
                  userRollno: widget.data['uid'],
                  userUid: userUID)
            }
        });
    setState(() {
      visible = false;
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Chats()));
  }

  sendMessage(id, uid) {
    _firestore.collection('chatRoom').doc(id).update({
      'chats': FieldValue.arrayUnion([
        {
          'message': '',
          'money': widget.data['money'],
          'send': true,
          'moneyBool': true,
          'time': DateTime.now(),
          'uid': uid,
        }
      ])
    });
  }

  createRoom(
      {required String? userUid,
      required String? userRollno,
      required String? rollno}) async {
    String? uid = preferenceHelper.preferences.getString('uid');
    String? name = preferenceHelper.preferences.getString('name');

    DocumentReference snap =
        _firestore.collection('chatRoom').doc('$rollno-$userRollno');
    snap.set({
      'chats': [],
    });
    _firestore.collection('profile').doc(uid).update({
      'feed': FieldValue.arrayUnion([
        {'name': userName, 'uid': snap.id, 'userUid': userUID}
      ])
    });
    _firestore.collection('profile').doc(userUID).update({
      'feed': FieldValue.arrayUnion([
        {'name': name, 'uid': snap.id, 'userUid': uid}
      ])
    });
    sendMessage(snap.id, uid);
    return snap.id;
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  void initState() {
    getPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter Pin'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Enter Your Secrete Pin',
                          style: GoogleFonts.roboto(
                            fontSize: 35,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.all(20.0),
                          child: PinPut(
                            fieldsCount: 6,
                            onSubmit: (String pin) {
                              if (userPin == pin) {
                                sendMoney(context);
                              } else {
                                Fluttertoast.showToast(msg: 'Enter Wrong Pin');
                              }
                            },
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            submittedFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            selectedFieldDecoration: _pinPutDecoration,
                            followingFieldDecoration:
                                _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: Colors.deepPurpleAccent.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                            textColor: Colors.white,
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Confirm to Add',
                              style: TextStyle(fontSize: 22.0),
                            ),
                            onPressed: () {
                              if (userPin == _pinPutController.value.text) {
                                sendMoney(context);
                              } else {
                                Fluttertoast.showToast(msg: 'Enter Wrong Pin');
                              }
                            }),
                      ],
                    ),
                    Visibility(
                        visible: visible,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.white.withOpacity(0.5),
                          child: CircularProgressIndicator(),
                        ))
                  ],
                ),
              ),
            );
          },
        ));
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
