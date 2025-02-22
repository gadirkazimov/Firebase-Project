import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in as ${user!.email}'),
            TextButton(
                onPressed: FirebaseAuth.instance.signOut, 
                child: Text('Sign out'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0XFFFF0000))
              ),
            )
          ],
        ),
      ),
    );
  }
}
