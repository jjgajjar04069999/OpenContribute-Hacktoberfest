import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/GlobalState.dart';
import 'package:flutter_login_signup/pages/moneyWallet.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  GlobalState _store = GlobalState.instance;
  late TextEditingController _money;
  final TextEditingController t1 = new TextEditingController(text: "0");
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthenticationService _auth = AuthenticationService();

  bool visible = false;

  @override
  void initState() {
    super.initState();

    _money = TextEditingController();
    _store.set('money', '');
    _money.text = _store.get('money');
  }

  addTrans() async {
    setState(() {
      visible = true;
    });
    String? uid = preferenceHelper.preferences.getString('uid');
    String? rollno = preferenceHelper.preferences.getString('rollno');
    await _firestore.collection('profile').doc(uid).update({
      'transaction': FieldValue.arrayUnion([
        {
          'uid': uid,
          'money': _money.value.text,
          'send': false,
          'time': DateTime.now(),
          'rollNo': rollno,
          'name': 'self'
        }
      ])
    });
    setState(() {
      visible = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add Money'),
          backgroundColor: Colors.black,
          elevation: 1,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: AssetImage('images/addmoney.PNG'),
                  radius: 70,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _money,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      LimitRangeTextInputFormatter(0, 500),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Amount',
                      hintText: 'Enter Amount less than 500',
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          splashColor: Colors.black,
                          onPressed: () {
                            _money.clear();
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Confirm to Add',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    onPressed: () async {
                      addTrans();
                      String? uid =
                          preferenceHelper.preferences.getString('uid');
                      List val = await _auth.addMoney(uid!, _money.value.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return new WalletApp(
                          money: val[0],
                          trans: val[1],
                        );
                      }));
                    }),
              ]),
            ),
            Visibility(
                visible: visible,
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ))
          ],
        ));
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      "Message",
      style: TextStyle(color: Colors.white),
    ),
    content: Text(
      " Money credited to your wallet",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.black,
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
