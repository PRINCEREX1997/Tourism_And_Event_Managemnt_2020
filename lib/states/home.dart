import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.get('First Name'));
      print(documentSnapshot.get('Last Name'));
      print(documentSnapshot.get('Email'));
    }
    );

    var firstName = '';
    var lastName = '';
    var email = '';
    return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: new Text("Welcome"),
            ),
            drawer: Drawer(
              elevation: 5.0,
              child: Column(children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(firstName),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text('Profile'),
                  ),
                ),
                ListTile(
                  title: Text('Events'),
                  leading: Icon(Icons.event),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text('Places'),
                  leading: Icon(Icons.location_city),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text('Manage Events'),
                  leading: Icon(Icons.assignment),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text('My Profile'),
                  leading: Icon(Icons.account_box),
                ),
                Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(
                        context
                    );
                  },
                ),
                Divider(
                  height: 1,
                )
              ]),
            ),
          ),
        ));
  }
}