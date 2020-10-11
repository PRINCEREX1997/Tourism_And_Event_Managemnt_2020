import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatelessWidget {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _notificationController = TextEditingController();

  Widget buildFirstName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'First Name',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        offset: Offset(0, 2)
                    ),
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _firstNameController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.blueGrey
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: Color(0xFF18FFFF),
                    )
                ),
              )
          )
        ]
    );
  }

  Widget buildLastName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Last Name',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        offset: Offset(0, 2)
                    ),
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _lastNameController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.blueGrey
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.account_box,
                      color: Color(0xFF18FFFF),
                    )
                ),

              )
          )
        ]
    );
  }

  Widget buildEmail(){
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Times New Roman",
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        offset: Offset(0,2)
                    ),
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Colors.blueGrey
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top:14),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF18FFFF),
                    )
                ),

              )
          )
        ]
    );
  }

  Widget buildPassword(){
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Times New Roman",
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        offset: Offset(0,2)
                    ),
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(
                    color: Colors.black54
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top:14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF18FFFF),
                    )
                ),
              )
          )
        ]
    );
  }

  Widget buildRePassword() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Re-Enter Password',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Times New Roman",
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
                        blurRadius: 2,
                        offset: Offset(0,2)
                    ),
                  ]
              ),
              height: 50,
              child: TextFormField(
                onChanged: (text) {
                  passMatch(text);
                },
                controller: _rePasswordController,
                obscureText: true,
                style: TextStyle(
                    color: Colors.black54
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top:14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF18FFFF),
                    )
                ),
              )
          ),
        ]
    );
  }

  Widget buildSignUpBtn(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: FlatButton(
          minWidth: 200,
          height: 50,
          onPressed: () {
            signUp();
          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white24,
          child: Text(
            'Sign  Up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Times New Roman"
            ),
          ),
        )
    );
  }

  void passMatch(String pass) {
    if (pass != _passwordController.text) {
      _notificationController.text = 'Pleae make sure your password match';
    } else if (_passwordController.text == '') {
      _notificationController.text = '';
    } else {
      _notificationController.text = '';
    }
  }

  void signUp() async {
    var firstName = _firstNameController.text;
    var lastName = _lastNameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    var uid = '';

    CollectionReference user = fireStore.collection('Users');

    if (firstName != '' && lastName != '' && email != '' && password != '') {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        uid = userCredential.user.uid;

        user.doc(uid).set(
            {
              'First Name': firstName,
              'Last Name': lastName,
              'Email': email,
            })
            .catchError((error) => print("Failed to add user: $error"));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _notificationController.text = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          _notificationController.text =
          'The account already exists for that email.';
        }
      } catch (e) {
        print(e);
      }
    } else {
      _notificationController.text = '* Fill required fields';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Smart Tourism",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: Color(0xDD6200EA),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    height: double.infinity,
                    width: double.infinity,
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
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                Text(
                                  'New User Registration',
                                  style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                )
                              ]
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildFirstName(),
                          SizedBox(
                            height: 20,
                          ),
                          buildLastName(),
                          SizedBox(
                            height: 20,
                          ),
                          buildEmail(),
                          SizedBox(
                            height: 20,
                          ),
                          buildPassword(),
                          SizedBox(
                            height: 20,
                          ),
                          buildRePassword(),
                          TextField(
                            controller: _notificationController,
                            style: TextStyle(
                                color: Colors.red
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(
                              width: 200,
                              height: 40,
                              child: buildSignUpBtn(context)
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )),
    );
  }
}
