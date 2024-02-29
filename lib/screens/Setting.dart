import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';
import 'package:mobdev_app/services/AuthService.dart';
import 'package:mobdev_app/services/StorageService.dart';
import 'package:mobdev_app/widgets/PrimaryButton.dart';

class Setting extends StatefulWidget {
  static String routeName = "/settings";

  @override
  State<Setting> createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  StorageService _storageService = StorageService();
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            padding: EdgeInsets.only(right: 50.0),
            child: const Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'SoDoSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.circle_notifications_rounded,
                size: 24.0,
              ),
              label: const Text('Notifications')),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.privacy_tip_rounded,
                size: 24.0,
              ),
              label: const Text('Security')),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.lock_rounded,
                size: 24.0,
              ),
              label: const Text('Privacy')),
          ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.build_circle_rounded,
                size: 24.0,
              ),
              label: const Text('About')),
          ElevatedButton.icon(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                          child: SpinKitFadingCube(
                        color: Colors.white,
                        size: 25,
                      ));
                    });
                await _authService.logout();
                _storageService.deleteAllData();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 24.0,
              ),
              label: const Text('Logout'))
        ],
      )),
    );
  }
}
