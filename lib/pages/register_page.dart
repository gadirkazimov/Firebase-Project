import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

  }

  bool passwordConfirmed() {
    if(_passwordController.text.trim() == _confirmedPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future addUserDetails(String uid, String firstName, String lastName, String email, String age) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'age': age
      });
      print("User data added to Firestore successfully!");
    } catch (e) {
      print("🔥 Firestore Error: $e");
    }
  }


  Future signUp() async {
    if (!passwordConfirmed()) {
      showErrorSnackbar(context); // Show an error message if passwords don't match
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String uid = userCredential.user!.uid;

      print("User registered with UID: $uid");

      await addUserDetails(uid, _firstNameController.text.trim(), _lastNameController.text.trim(), _emailController.text.trim(), _ageController.text.trim());

      print("User data added to Firestore successfully!");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration success!'),
          backgroundColor: Colors.green,
        ),
      );


    } on FirebaseAuthException catch (e) {
      // Show Firebase error messages
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Registration failed!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Passwords don\'t match. Please try again', style: TextStyle(color: Colors.white, fontSize: 18),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
      )
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
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        hintText: ' First Name',
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
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: ' Last Name',
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
                    controller: _ageController,
                    decoration: InputDecoration(
                        hintText: ' Age',
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
                    Text('If you have account?  ', style: TextStyle(fontSize: 18),),
                    GestureDetector(
                        onTap: widget.navigateLoginPage,
                        child: Text('Log In!', style: TextStyle(color: Colors.blue,fontSize: 18, fontWeight: FontWeight.w700),))
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
