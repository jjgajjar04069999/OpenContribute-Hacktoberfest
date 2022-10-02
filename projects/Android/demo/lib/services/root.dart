// this is not actually a screen here we decide whether the user is previously looged in
// or do we take user to the login page or home page
import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
import 'package:MechGesture/pages/SplashScreen/SplashPage.dart';
import 'package:MechGesture/pages/authentication/screen/Register.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loogedIn,
}


class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  // by default the user is not logged in
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state , check the state, check current userm set authstatus based on state
    CurrentState _currentUser = Provider.of<CurrentState>(context, listen:false);
    String _returnString = await _currentUser.onStartUpAPI();

    if(_returnString =="success") {
      setState(() {
        print("the user is logged in");
        _authStatus = AuthStatus.loogedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = Register();
        break;
      case AuthStatus.loogedIn:
        retVal = HomeScreen();
        break;
    }
    return retVal;
  }
}
