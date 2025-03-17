import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('User Profile',))
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("User data not found"));
          }

          var userData = snapshot.data!.data();
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("First Name: ${userData!['first_name']}", style: TextStyle(fontSize: 20),),
                Text("Last Name: ${userData['last_name']}",  style: TextStyle(fontSize: 20),),
                Text("Age: ${userData['age']}",  style: TextStyle(fontSize: 20),),
                Text("Email: ${userData['email']}",  style: TextStyle(fontSize: 20),),

                SizedBox(height: 50,),
                Center(
                  child: TextButton(
                    onPressed: FirebaseAuth.instance.signOut,
                    child: Text('Sign out', style: TextStyle(fontSize: 18),),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color(0XFFFF0000)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)
                    ),),
                )
                  ],
            ),
          );
        },
      ),
    );
  }
}
