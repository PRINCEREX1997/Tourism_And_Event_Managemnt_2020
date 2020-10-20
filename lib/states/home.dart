import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference places = FirebaseFirestore.instance.collection('Places');

  Widget loadingWindow() {
    return Scaffold(
      body: Container(
        child: Icon(Icons.error),
      ),
    );
  }

  Widget streamBuild<QuerySnapshot>() {
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
            final List district = snapshot.data.documents.map<String>((doc) =>
                (doc.id).toString()).toList();

            return Container(
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
                    ]
                ),
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 500,
                  diameterRatio: 5,
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/smarttourism-20178273.appspot.com/o/District%2FVavuniya.jpg?alt=media&token=ffe8be69-e3c3-48c0-a838-4f92d149da7d",
                            height: 430,
                            width: 500,
                            fit: BoxFit.fill,
                          ),
                          FlatButton(
                            minWidth: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 50,
                            onPressed: () {},
                            color: Colors.white10,
                            child: Text(
                              district.elementAt(index),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 32,
                                fontFamily: "Times new Roman",
                              ),
                            ),
                          ),
                        ],
                      );
                    }, childCount: 25,
                  )
              ),
            );
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return streamBuild();
  }
}
