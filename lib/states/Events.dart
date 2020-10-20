import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _firstName = '';
    var _lastName = '';
    var _email = '';

    print(_firstName);
    print(_lastName);
    print(_email);
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xDD6200EA),
                  title: new Text("Welcome"),
                ),
                drawer: Drawer(
                    elevation: 5.0,
                    child: Container(
                      color: Color(0x666200EA),
                      child: Column(children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName:
                              Text("Name: : " + _firstName + _lastName),
                          accountEmail: Text("Email : " + _email),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white30,
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
                            Navigator.pop(context);
                          },
                        ),
                        Divider(
                          height: 1,
                        )
                      ]),
                    )),
                body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xDD6200EA),
                            Color(0xAA6200EA),
                            Color(0x996200EA),
                            Color(0x886200EA),
                            Color(0x776200EA),
                            Color(0x666200EA),
                            Color(0x666200EA),
                          ]),
                    ),
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 500,
                      diameterRatio: 5,
                      childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              color: Colors.white30,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  Image(
                                    image:
                                        AssetImage("lib/assets/test event.jpg"),
                                  )
                                ],
                              ),
                            );
                          },
                          childCount: 100),
                    )))));
  }
}
