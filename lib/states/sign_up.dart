import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Widget buildEmail(){
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:5),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 6,
                        offset: Offset(0,2)
                    )
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Colors.blueGrey
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
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:5),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey,
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
  Widget buildName(){
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Name',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height:5),
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey,
                        blurRadius: 6,
                        offset: Offset(0,2)
                    )
                  ]
              ),
              height: 50,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Colors.blueGrey
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
             fontSize: 32,
           ),
         ),
         backgroundColor: Color(0xDD6200EA),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
        }),
      ),

      drawer: Drawer(
        
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
                          vertical: 100
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: "Times New Roman",
//                            color: Colors.blueAccent,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              )
                            ]
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          buildName(),
                          SizedBox(
                            height: 50,
                          ),
                          buildEmail(),
                          SizedBox(
                            height: 50,
                          ),
                          buildPassword(),
                          SizedBox(
                            height: 20,
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
