import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/GlobalState.dart';
import 'package:flutter_login_signup/pages/pinScreen.dart';

class SendMoney extends StatefulWidget {
  late final data;

  SendMoney(this.data);

  @override
  State<SendMoney> createState() => _SendMoneyState(this.data);
}

class _SendMoneyState extends State<SendMoney> {
  GlobalState _store = GlobalState.instance;

  _SendMoneyState(data);

  late TextEditingController _money;
  final AuthenticationService _auth = AuthenticationService();

  final TextEditingController t1 = new TextEditingController(text: "0");
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  late String pin;

  @override
  void initState() {
    super.initState();

    print('${widget.data} ++++++step reached');

    _money = TextEditingController();
    _store.set('money', '');
    _money.text = _store.get('money');
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Receive Money'),
        ),
        body: Padding(
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  LimitRangeTextInputFormatter(0, 500),
                ],
                keyboardType: TextInputType.number,
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
                  'Receive',
                  style: TextStyle(fontSize: 22.0),
                ),
                onPressed: () {
                  String? uid = preferenceHelper.preferences.getString('uid');
                  _auth.addMoney(uid!, _money.value.text);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => PinScreen(
                          {'money': _money.value.text, 'uid': widget.data})));
                }),
          ]),
        ));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen()));
  }
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Balance'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          " The balance in the wallet is ",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
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
