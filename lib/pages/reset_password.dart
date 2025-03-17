import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose () {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword () async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim()
      );
      showConfirmedText();

    } on FirebaseAuthException catch (e) {
      showErrorText(e);}
  }

  void showErrorText (FirebaseAuthException e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString(), style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )
    );
  }

  void showConfirmedText () {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Password reset link sended to email', style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
        )
    );
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,)
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your Email and we will send you password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200]
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: ' Email',
                    hintStyle: TextStyle(fontSize: 18),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          TextButton(
          onPressed: resetPassword,
            child: Text('Reset Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple[300],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                
            ),
          )
        ],
      ),
    );
  }
}
