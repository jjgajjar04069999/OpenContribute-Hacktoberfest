import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/pages/AddMoney.dart';
import 'package:flutter_login_signup/pages/ProfileUI1.dart';
import 'package:flutter_login_signup/pages/moneyWallet.dart';
import 'package:flutter_login_signup/pages/sendMoney.dart';

import 'ProfileUI1.dart';
import 'chats.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  late String uid;
  String _scanBarcode = 'Unknown';

  final AuthenticationService _auth = AuthenticationService();

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (barcodeScanRes == '-1') {
      print('cancel');
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => SendMoney(barcodeScanRes)));
    }

    if (!mounted) return;
    print('$barcodeScanRes +++++ step 1');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          RaisedButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settings1()));
            },
            child: Icon(
              Icons.account_circle_sharp,
              size: 50,
              color: Colors.white,
            ),
            color: Colors.black,
          ),
        ],
      ),
      body: new Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Text(
                          "I-Pay",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        new Padding(padding: EdgeInsets.all(5.0)),
                        new Text(
                          "Our very own wallet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )),
            new Container(
              padding: EdgeInsets.only(left: 0, top: 50, right: 0, bottom: 50),
              margin: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 150.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.search,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              new Text(
                                "MONEY IN WALLET",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletApp()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      new Container(
                        height: 150.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.pages,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              new Text(
                                "ADD MONEY",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMoney()));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 150.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(
                                Icons.print,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              new Text(
                                "RECEIVE MONEY",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              )
                            ],
                          ),
                          onTap: () {
                            scanBarcodeNormal();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      new Container(
                          height: 150.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: InkWell(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.chat,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                new Text(
                                  "DASHBOARD",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                )
                              ],
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Chats()),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
