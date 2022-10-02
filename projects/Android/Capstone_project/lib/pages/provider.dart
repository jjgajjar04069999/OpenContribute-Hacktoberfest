import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final AuthenticationService ?auth;

  Provider({Key ?key, required Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType() as Provider);
}