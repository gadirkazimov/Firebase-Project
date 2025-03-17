/*
Column(
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
 */

/*
Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream() {
  return FirebaseFirestore.instance.collection('users').snapshots();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('All Users')),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getAllUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No users found"));
        }

        var users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index].data();
            return ListTile(
              title: Text("${user['first_name']} ${user['last_name']}"),
              subtitle: Text("Age: ${user['age']} | Email: ${user['email']}"),
            );
          },
        );
      },
    ),
  );
}
 */