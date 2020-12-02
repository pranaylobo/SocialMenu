import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/upload.dart';

import 'Menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'Menu.dart';
import 'login.dart';
import 'widgets/auto_refresh.dart';
import 'widgets/empty_card.dart';
import 'package:like_button/like_button.dart';
import 'package:nice_button/nice_button.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

void main() {


  runApp(MaterialApp(
    home: CustomSplash(
      imagePath: 'assets/images/firebase.png',
      backGroundColor: Colors.redAccent,
      // backGroundColor: Color(0xfffc6042),
      animationEffect: 'zoom-in',
      logoSize: 200,
      home: MainMenu(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    ),
  ));
}
class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _CardColumnScreenState createState() => _CardColumnScreenState();

}

class _CardColumnScreenState extends State<MainMenu> {
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
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  SizedBox(
                    height: 20.0,
                  ),

                  // Text(
                  //   'Burrger By Codellion',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
                  // ),




Padding(
  padding: EdgeInsets.only(left: 120),
  child:Row(crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        NiceButton(
        width: 100,
        elevation: 8.0,
        text: "Login",fontSize: 15,
        background: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => login()),
          );

          },
      ),

        NiceButton(
          width: 100,
          elevation: 8.0,
          text: "Upload",textColor: Colors.red,fontSize: 15,
          background: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => upload()),
            );          },
        ),
      ],
  ),
),

                  Image.asset("assets/images/banner2.png",height: 350,),




                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.deck,color: Colors.blueAccent)

                        ,
                        const Icon(Icons.restaurant,color: Colors.red,),
                        const Icon(Icons.menu_book,color: Colors.green,),
                      ],
                    ),
                  ),
                  Row(

                    children: [

                      Flexible(
                          child: Container(


                            width:200,
                            height: 150,
                            child: FlatButton(
                                onPressed: () => {
                                  //do something
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu()),
                                  ),
                                },
                                padding: EdgeInsets.all(0),
                                child: Image.asset('assets/images/burger.jpg',
                                    fit: BoxFit.cover)),
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4.0,
                                  offset: const Offset(0.0, 4.0),
                                ),
                              ],

                            ),



                          )),


                      Flexible(child:Container(
                        width:200,
                        height: 150,
                        child: FlatButton(
                            onPressed: () => {
                              //do something
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()),
                              ),
                            },
                            padding: EdgeInsets.all(0),
                            child: Image.asset('assets/images/chickenwings.jpg',
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(child:Container(
                        width:200,
                        height: 150,
                        child: FlatButton(
                            onPressed: () => {
                              //do something
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()),
                              ),
                            },
                            padding: EdgeInsets.all(0),
                            child: Image.asset('assets/images/nachos.jpg',
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                      )),
                      Flexible(child:Container(
                        width:200,
                        height: 150,
                        child: FlatButton(
                            onPressed: () => {
                              //do something
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()),
                              ),
                            },
                            padding: EdgeInsets.all(0),
                            child: Image.asset('assets/images/onionring.jpg',
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(child:Container(
                        width:200,
                        height: 150,
                        child: FlatButton(
                            onPressed: () => {
                              //do something
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()),
                              ),
                            },
                            padding: EdgeInsets.all(0),
                            child: Image.asset('assets/images/mohitos.jpg',
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                      )),
                      Flexible(child:Container(
                        width:200,
                        height: 150,
                        child: FlatButton(
                            onPressed: () => {
                              //do something
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()),
                              ),
                            },
                            padding: EdgeInsets.all(0),
                            child: Image.asset('assets/images/icecream.jpg',
                                fit: BoxFit.cover)),
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4.0,
                              offset: const Offset(0.0, 4.0),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
