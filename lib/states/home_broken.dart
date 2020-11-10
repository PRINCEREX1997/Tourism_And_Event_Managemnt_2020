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
            final List district = snapshot.data.documents
                .map<String>((doc) => (doc.id).toString())
                .toList();

            final List url = snapshot.data.documents
                .map<String>((doc) => (doc.data()['ImgUrl']).toString())
                .toList();

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
                      Color(0xAA6200EA),
                      Color(0xDD6200EA),
                    ]),
              ),
              width: MediaQuery.of(context).size.width,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 600,
                  diameterRatio: 3,
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('Taped here ' + district.elementAt(index));
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                url.elementAt(index),
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                width: MediaQuery.of(context).size.height * 0.9,
                                fit: BoxFit.fill,
                              ),
                              RaisedButton(
                                onPressed: () => print('Pressed'),
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => Places()
//                                  )
//                              ),
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
                          ),
                        ),
                      );
                    },
                    childCount: 25,
                  )),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return streamBuild();
  }
}
