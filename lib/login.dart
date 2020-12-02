import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter_app/register.dart';


import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'Menu.dart';
import 'widgets/auto_refresh.dart';
import 'widgets/empty_card.dart';
import 'package:like_button/like_button.dart';
import 'package:nice_button/nice_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() {


  runApp(MaterialApp(
    // home: CustomSplash(
    //   imagePath: 'assets/images/codelliontranswhite.png',
    //   backGroundColor: Colors.redAccent,
    //   // backGroundColor: Color(0xfffc6042),
    //   animationEffect: 'zoom-in',
    //   logoSize: 200,
    //   home: login(),
    //   duration: 2500,
    //   type: CustomSplashType.StaticDuration,
    // ),

    home:login()
  ));
}
class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _CardColumnScreenState createState() => _CardColumnScreenState();

}

class _CardColumnScreenState extends State<login> {
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final databaseReference = Firestore.instance;


  bool _toogle = false;


  @override
  Widget build(BuildContext context) {
    int _n = 0;

    void add() {
      setState(() {
        _n++;
      });
    }
    void minus() {
      setState(() {
        if (_n != 0)
          _n--;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: AnimationLimiter(
              child: Container(

                  child: Column(children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("Social Recipe", style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),),
                    SizedBox(
                      height: 20.0,
                    ),

                    Image.asset("assets/images/firebase.png", height: 250,),

                    SizedBox(
                      height: 30.0,
                    ),


                    Container(

                          child: Column(
                            children: [
                              TextField(
                                controller: myController,

                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: new TextStyle(
                                        color: Colors.grey[800]),
                                    hintText: "Email Address",
                                    fillColor: Colors.white70),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextField(
                                controller: myController1,
                                obscureText: true,

                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: new TextStyle(
                                        color: Colors.grey[800]),
                                    hintText: "Password",
                                    fillColor: Colors.white70),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              NiceButton(
                                width: 255,
                                elevation: 8.0,
                                radius: 52.0,
                                text: "Login",
                                background: Colors.red,
                                onPressed: () {
                                  print("hello" + myController.text);

                                  signUp(myController.text, myController1.text);
                                },
                              ),
                            ],
                          )
                      ),


                    SizedBox(
                      height: 20.0,
                    ),

                    // NiceButton(
                    //   width: 205,
                    //   elevation: 8.0,
                    //   radius: 52.0,
                    //   text: "Register",
                    //   background: Colors.blue,
                    //   onPressed: () {
                    //     print("register");
                    //     _toogle=true;
                    //
                    //     setState(() {
                    //
                    //       cardKey.currentState.toggleCard();
                    //     });
                    //     },
                    // ),

                    new InkWell(
                        child: new Text('Register  Now!',
                          style: TextStyle(color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => register()),
                          );
                        }

                    ),

                  ])
              )

          ),
        ),
      ),
    );
  }


  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await auth.signInWithEmailAndPassword(
        email: email, password: password);
    hello();

    return user.uid;

  }

  void hello() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Menu()),
    );

  }
}