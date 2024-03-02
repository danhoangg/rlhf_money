import 'package:flutter/material.dart';
import 'package:rlhf_money/pages/login_page.dart';
import 'package:rlhf_money/pages/signup_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;

  void _toggleLogin() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(onPressed: _toggleLogin);
    } else {
      return SignUpPage(onPressed: _toggleLogin);
    }
  }
}
