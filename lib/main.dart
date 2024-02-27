import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_app/routes.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA49ivropSplctTRqMZKwFRepHf-fH9vOI",
          appId: "MobDevFinals",
          messagingSenderId: "607981381511",
          projectId: "mobdevfinals-45868"));
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.brown,
      scaffoldBackgroundColor: Color.fromARGB(255, 66, 133, 91),
      textTheme: TextTheme(
        displaySmall: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
}
