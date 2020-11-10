import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarttourism/states/home.dart';
import 'package:smarttourism/states/screenRoute.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  CollectionReference places = FirebaseFirestore.instance.collection('Places');
  var name;
  var imgUrl;
  var email;
  var pNum;
  final User user = FirebaseAuth.instance.currentUser;

  Widget loadingWindow() {
    return Scaffold(
      body: Container(
        child: Icon(Icons.error),
      ),
    );
  }

  Widget streamBuild<QuerySnapshot>() {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Users").doc(user.uid);
    if (user.displayName == null) {
      document.get().then((value) {
        var fname = value.data()["First Name"].toString();
        var lname = value.data()["Last Name"].toString();
        name = fname.toString() + " " + lname.toString();
        imgUrl = value.data()["ImgUrl"].toString();
        email = value.data()["Email"].toString();
        pNum = value.data()["Mobile Number"].toString();
      });
    } else {
      name = user.displayName;
      email = user.email;
      imgUrl = user.photoURL;
      pNum = user.phoneNumber;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose Location'),
          backgroundColor: Color(0xDD6200EA),
        ),
        body: StreamBuilder(
          stream: places.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return loadingWindow();
            }
            final List district = snapshot.data.documents
                .map<String>((doc) => (doc.id).toString())
                .toList();

            final List url = snapshot.data.documents
                .map<String>((doc) => (doc.data()['ImgUrl']).toString())
                .toList();
            //0xDD6200EA
            return Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6200EA),
                  border: Border.all(
                    color: Color(0xFF6200EA),
                    width: 8,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 25,
                  itemExtent: 500,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white10,
                          width: 8,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            url.elementAt(index),
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.height * 0.9,
                            fit: BoxFit.fill,
                          ),
                          FlatButton(
                            minWidth: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.15,
                            onPressed: () {
                              Userdata userdata =
                                  Userdata(name, imgUrl, email, pNum);
                              HomeScreenArgs homeScreenArgs = HomeScreenArgs(
                                  userdata, district.elementAt(index));
                              print(homeScreenArgs.userdata.name);
                              print(homeScreenArgs.location);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(),
                                      settings: RouteSettings(
                                        arguments: homeScreenArgs,
                                      )));
                            },
                            color: Colors.white10,
                            child: Text(
                              district.elementAt(index),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontFamily: "Times new Roman",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return streamBuild();
  }
}
