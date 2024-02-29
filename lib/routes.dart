import 'package:flutter/material.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';
import 'package:mobdev_app/screens/Setting.dart';
import 'package:mobdev_app/screens/Signup.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  Dashboard.routeName: (BuildContext context) => Dashboard(),
  Setting.routeName: (BuildContext context) => Setting(),
  Signup.routeName: (BuildContext context) => Signup(),
};
