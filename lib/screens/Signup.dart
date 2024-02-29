import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobdev_app/screens/Dashboard.dart';
import 'package:mobdev_app/screens/LoginScreen.dart';
import 'package:mobdev_app/screens/Setting.dart';
import 'package:mobdev_app/screens/Signup.dart';
import 'package:mobdev_app/widgets/CustomTextField.dart';
import 'package:mobdev_app/widgets/PasswordField.dart';
import 'package:mobdev_app/widgets/PrimaryButton.dart';

class Signup extends StatefulWidget {
  static String routeName = "/signup";

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool obscurePassword = true;
  bool passwordTooWeak = false;
  bool emailAlreadyExist = false;
  bool passwordMismatch = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width * .9,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Email Address",
                    hintText: "Enter your email address",
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                  ),
                  Visibility(
                    child: Text(
                      'The account already exists for that email.',
                    ),
                    visible: emailAlreadyExist,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                    obscureText: obscurePassword,
                    onTap: handleObscurePassword,
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                  Visibility(
                    child: Text(
                      'The password provided is too weak.',
                    ),
                    visible: passwordTooWeak,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                    obscureText: obscurePassword,
                    onTap: handleObscurePassword,
                    labelText: "Confirm Password",
                    hintText: "Re-enter your password",
                    controller: confirmPassController,
                  ),
                  Visibility(
                    child: Text(
                      'Passwords do not match.',
                    ),
                    visible: passwordMismatch,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Signup",
                    iconData: Icons.person_add,
                    onPress: () {
                      signUp();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                    text: "Already have an account?",
                    iconData: Icons.login,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetChecks() {
    setState(() {
      obscurePassword = true;
      passwordTooWeak = false;
      emailAlreadyExist = false;
      passwordMismatch = false;
    });
  }

  handleConfirmPassword() {
    if (passwordController.text != confirmPassController.text) {
      setState(() {
        passwordMismatch = true;
      });
    } else {
      passwordMismatch = false;
    }
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  signUp() async {
    resetChecks();
    handleConfirmPassword();
    if (!passwordMismatch) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                  child: SpinKitFadingCube(
                color: Colors.white,
                size: 25,
              ));
            });
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        if (e.code == 'weak-password') {
          setState(() {
            passwordTooWeak = true;
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            emailAlreadyExist = true;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
