import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  VoidCallback navigateRegisterPage;
  LoginPage({super.key, required this.navigateRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                Text('Sign In', style: TextStyle(fontSize: 30, color: Colors.grey[700], fontWeight: FontWeight.w700), ),
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
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: logIn,
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
                    Text('Not a member?  ', style: TextStyle(fontSize: 16),),
                    GestureDetector(
                        onTap: widget.navigateRegisterPage,
                        child: Text('Register now!', style: TextStyle(color: Colors.blue,fontSize: 16),)
                    )
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
