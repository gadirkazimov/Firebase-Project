import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  VoidCallback navigateLoginPage;
  RegisterPage({super.key, required this.navigateLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
  }

  bool passwordConfirmed() {
    if(_passwordController.text.trim() == _confirmedPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if(passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } else {
      showErrorDialog(context, "Passwords do not match. Please try again.");
    }
  }


  void showErrorDialog (BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog (
            title: Text("Sign Up Error"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign Up', style: TextStyle(fontSize: 30, color: Colors.grey[700], fontWeight: FontWeight.w700), ),
                SizedBox(height: 45,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: ' Email',
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: ' Password',
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200]
                  ),
                  child: TextField(
                    controller: _confirmedPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[700]
                    ),
                    child: Center(child: Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('If you have account?  ', style: TextStyle(fontSize: 16),),
                    GestureDetector(
                        onTap: widget.navigateLoginPage,
                        child: Text('Log In!', style: TextStyle(color: Colors.blue,fontSize: 16),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
