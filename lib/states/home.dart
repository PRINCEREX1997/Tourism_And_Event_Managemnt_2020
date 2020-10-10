import 'package:flutter/material.dart';

class home extends StatelessWidget {
  var ename = 'Pirunthapan Y.';
  var email = '2017e082@eng.jfn.ac.lk';
  @override
  Widget build(BuildContext context) {
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
                  accountName: Text("$ename"),
                  accountEmail: Text("$email"),
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