import 'package:firebasetutorial/pages/login_page.dart';
import 'package:firebasetutorial/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage =! showLoginPage;
    });
}

  @override
  Widget build(BuildContext context) {
    return showLoginPage==true ?  LoginPage(navigateRegisterPage: togglePages,) : RegisterPage(navigateLoginPage: togglePages);
  }
}