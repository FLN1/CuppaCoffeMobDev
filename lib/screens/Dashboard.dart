import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobdev_app/screens/Settings.dart';
import 'package:mobdev_app/arguments/FormData.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            padding: EdgeInsets.only(left: 50.0),
            child: const Text(
              'Dashboard',
              style: TextStyle(
                fontFamily: 'SoDoSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Settings.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50.0, left: 10, right: 10),
            child: Center(
              child: Text(
                // "Hello, ${(formdata.email)}!",
                user.email!,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontFamily: 'SoDoSans',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
