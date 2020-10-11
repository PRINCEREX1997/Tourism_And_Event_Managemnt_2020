import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smarttourism/states/Home.dart';
import 'package:smarttourism/states/sign_up.dart';

final FirebaseAuth _auth =FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }
  return null;
}

void _login(BuildContext context) async {
  try{
    final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
    )).user;
    if (user != null) {
      print(user.uid);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home(),)
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

class LogIn extends StatefulWidget {

  @override
  _LogInState createState() => _LogInState();

}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isRememberMe = false;

  Widget googleSignInButton() {
    return OutlineButton(
      color: Colors.white10,
      splashColor: Colors.white,
      onPressed: () {
        signInWithGoogle().then((result) {
          print(result);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) {
                  return home();
                }
            ),
          );
        });
      },

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white70, width: 2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("lib/assets/google_logo.png"), height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
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
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:5),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white10,
                        blurRadius: 500,
                        offset: Offset(0,5)
                    )
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Colors.black
                ),
                validator: (String value){
                  if(value.isEmpty){
                    return 'Email';
                  }
                  return null;
                },
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
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:5),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white10,
                        blurRadius: 6,
                        offset: Offset(0,2)
                    )
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(
                    color: Colors.black54
                ),
                validator: (String value){
                  if(value.isEmpty){
                    return 'Email';
                  }
                  return null;
                },
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

  Widget buildForgotPassBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
          onPressed: ()=> print("Forgot Password"),
          padding: EdgeInsets.only(right:0),
          child: Text(
            'Forgot Password?',
            style:TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
        height: 20,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(

                value: isRememberMe,
                checkColor: Colors.black,
                activeColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    isRememberMe = value;
                  });
                },
              ),
            ),
            Text(
              'Remember me',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        )
    );
  }

  Widget buildLoginBtn(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: FlatButton(
          minWidth: 200,
          onPressed: () async {
            _login(context);
          },
          padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: Colors.white10,
          child: Text(
            'Log In',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Times New Roman"
            ),
          ),
        )
    );
  }

  Widget buildSignUpBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SignUp(),)
        )
      },
      child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: 'Don\'t have an Account?   ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: "Times new Roman"
                    )
                ),

                TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Times new Roman"
                    )
                )
              ]
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Smart Tourism',
          style: TextStyle(
              fontFamily: "Times New Roman",
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xDD6200EA),
      ),
      key: _formKey,
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
                          vertical: 20
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          buildEmail(),
                          SizedBox(
                            height: 20,
                          ),
                          buildPassword(),
                          Row(
                            children: <Widget>[
                              buildRememberCb(),
                              SizedBox(
                                width: 100,
                              ),
                              buildForgotPassBtn(),
                            ],
                          ),
                          SizedBox(
                              width: 250,
                              child: buildLoginBtn(context)
                          ),
                          Text(
                            'or',
                            style: TextStyle(
                              fontFamily: 'Times New Roman',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          googleSignInButton(),
                          SizedBox(
                            height: 25,
                          ),
                          buildSignUpBtn(context)
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
