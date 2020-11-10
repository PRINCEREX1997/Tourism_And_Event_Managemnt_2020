import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceTab extends StatelessWidget {
  var loc = 'Vavuniya';

  Query attraction = FirebaseFirestore.instance
      .collection('Attractions')
      .doc('RelegiousPlaces')
      .collection('Temple');

  Widget loadingWindow() {
    return Container(
      child: Icon(Icons.error),
    );
  }

  Widget streamBuild<QuerySnapshot>() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFFB2EBF2),
              Color(0xAA03A9F4),
              Color(0x8803A9F4),
              Color(0xAA03A9F4),
              Color(0xFFB2EBF2),
              Color(0xAA03A9F4),
              Color(0xAA03A9F4),
              Color(0xFF03A9F4),
              Color(0xFF03A9F4),
              Color(0xFFB2EBF2),
              Color(0xAA03A9F4),
              Color(0x8803A9F4),
              Color(0xAA03A9F4),
              Color(0xAA03A9F4),
              Color(0xFFB2EBF2),
              Color(0xAA03A9F4),
            ])),
        child: StreamBuilder(
            stream: attraction.where("District", isEqualTo: loc).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return loadingWindow();
              }
              final List name = snapshot.data.documents
                  .map<String>((doc) => (doc.id).toString())
                  .toList();
              final List address = snapshot.data.documents
                  .map<String>((doc) => (doc.data()['Address']).toString())
                  .toList();
              final List url = snapshot.data.documents
                  .map<String>((doc) => (doc.data()['ImgUrl']).toString())
                  .toList();
              return ListView.builder(
                  itemCount: name.length,
                  itemExtent: 180,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * .05,
                              right: 0,
                              left: 5),
                          child: new Container(
                            height: MediaQuery.of(context).size.width * .30,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF64FFDA),
                                      Color(0x8803A9F4),
                                      Color(0x8803A9F4),
                                      Color(0xAA03A9F4),
                                      Color(0xFF03A9F4),
                                      Color(0xFF03A9F4),
                                      Color(0xAA03A9F4),
                                      Color(0x8803A9F4),
                                      Color(0x8803A9F4),
                                      Color(0xFF64FFDA),
                                    ]),
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.topLeft,
                          padding:
                              new EdgeInsets.only(top: 0, right: 20.0, left: 0),
                          child: new Container(
                            height: MediaQuery.of(context).size.width * .40,
                            width: MediaQuery.of(context).size.width * .40,
                            child: new Card(
                              elevation: 50,
                              child: Image.network(
                                url.elementAt(index),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                              color: Colors.white10,
                            ),
                          ),
                        ),
                        InkWell(
                          child: new Container(
                              alignment: Alignment.topRight,
                              padding: new EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width * .06,
                                  right:
                                      MediaQuery.of(context).size.width * .015,
                                  left: 0),
                              child: new Container(
                                height: MediaQuery.of(context).size.width * .28,
                                width: MediaQuery.of(context).size.width * .53,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .12,
                                      child: Text(
                                        name.elementAt(index),
                                        style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .12,
                                      child: Text(
                                        address.elementAt(index),
                                        style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          onTap: () {
                            print(name.elementAt(index));
                          },
                        )
                      ],
                    );
                  });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x336200EA), body: Center(child: streamBuild()));
  }
}
