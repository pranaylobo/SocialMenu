import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:card_selector/card_selector.dart';
import 'dart:math';
import 'package:like_button/like_button.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:steps/steps.dart';
import 'package:expansion_card/expansion_card.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() =>
{
// new HttpClient().getUrl(Uri.parse('https://raw.githubusercontent.com/pranaylobo/test-git/main/in.json'))
//     .then((HttpClientRequest request) => request.close())
//     .then((HttpClientResponse response) =>
//     response.transform(new Utf8Decoder()).listen(print)),

runApp(Menu())

    };




class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    var t = Theme.of(c)
        .textTheme
        .apply(displayColor: Colors.white70, bodyColor: Colors.white70);
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, textTheme: t),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HState createState() => _HState();

}

class _HState extends State<Home> {

  List _cs;
  Map _c;
  double _w = 0;
  int _n = 0;
  int counter12 = 0;
  List<int> data = [];
  int currentLength = 0;
  int hello=0;
  bool check = false;
  var num_list = [];
  var num_list1 = [];
  var comment_sec=["Good Video","Would Like To see More","Awesome!!"];
  double me_x = 400;
  final int increment = 10;
  bool isLoading = false;
  bool _bool =false;
  bool menu = true ;
  bool comments = false ;
  bool notes = false ;
  bool viewVisible = false;

  final myController1 = TextEditingController();

  final databaseReference = Firestore.instance;

  void showWidget()
  {
    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidget(){
    setState(() {
      viewVisible = false ;
    });
  }

  _makeGetRequest() async {
    // make GET request
    String url = 'https://db897b91c7e3.ngrok.io/';
    Response response = await get(url);
    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json1 = response.body;
    print(json1);
    _cs = json.decode(json1);
    setState(() =>
    {
      _c = _cs[0],


      num_list=_c["title"],
      num_list1=_c["description_steps"],



    }
    );
    // TODO convert json to object...
  }


  @override
  void initState() {
    super.initState();
    // DefaultAssetBundle.of(context).loadString("assets/images/in.json").then((d) {
    //   _cs = json.decode(d);
    //   setState(() => _c = _cs[0]);
    //
    // });
    _makeGetRequest();



  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }


  @override
  Widget build(BuildContext c) {
    // print(num_list[0]);

    void change(index)
    {
      setState(() {
        counter12=index;
        check=true;
      });
    }
    void add() {
      setState(() {
        _n=_n+1;
      });
    }
    void minus() {
      setState(() {
        if (_n != 0)
          _n--;
      });
    }
    if (_cs == null) return Container();
    var tt = Theme.of(c).textTheme;

    if (_w <= 0) _w = MediaQuery.of(context).size.width - 40.0;

    return Scaffold(

        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomBarWithSheet(
          isOpened: check,
          selectedIndex: counter12,

          sheetChild:

            ListView.builder(
              itemCount: num_list.length,
              itemBuilder: (context, position) {
                print(position);
                return DemoItem(position,check,menu,comments,num_list,num_list1,comment_sec);
              },
            ),

            bottomBarTheme: BottomBarTheme(
              // heightOpened: MediaQuery.of(context).size.height-100,
              heightOpened: me_x,
            mainButtonPosition: MainButtonPosition.Middle,
            selectedItemBackgroundColor:  Colors.red,
            backgroundColor: Colors.black

          ),
          mainActionButtonTheme: MainActionButtonTheme(
            size: 60,
            color: Colors.red,
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
          onSelectItem: (index) =>
          {
            print('item $index was pressed'),

            if(index ==0)
            {
              //Execute this part of the code if the condition is true.

              setState(() {
               menu = true ;
               comments = false ;
               // ListView.builder(
               //   itemCount: 10,
               //   itemBuilder: (context, position) {
               //     return DemoItem(position,check,menu,comments);
               //   },
               // );


            })

  }
            else if (index ==1){
              //Execute this part of the code if the condition is not true.
              setState(() {
                 menu = false ;
                 comments = true ;
                 check=true;

                // ListView.builder(
                 //   itemCount: 10,
                 //   itemBuilder: (context, position) {
                 //     return DemoItem(position,check,menu,comments);
                 //   },
                 // );

              })
            }
            else if (index ==2){
        //Execute this part of the code if the condition is not true.
        setState(() {
          // me_x=MediaQuery.of(context).size.height-100;
          showPlatformDialog(
            context: context,
            builder: (_) => BasicDialogAlert(
              title: Text("Comment Your Opinions"),
              content:
              TextField(
                controller: myController1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write Your Comment'
                ),
              ),
              actions: <Widget>[
                BasicDialogAction(
                  title: Text("OK"),
                  onPressed: () {
                    me_x=400;

                    setState(() =>
                    {
                      comment_sec.add(myController1.text),
                    Navigator.of(context, rootNavigator: true).pop(context),

                     databaseReference.collection("Recipe")
                        .document(_c['recipename'])
                        .updateData({
                    'comment':comment_sec,


                    }),

                        print("document writtern"),




                    },
                    );
                  },
                ),
              ],
            ),
          );
      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (context, position) {
      //     return DemoItem(position,check,menu,comments);
      //   },
      // );

    })
    }
            else if (index ==3){
        //Execute this part of the code if the condition is not true.
        setState(() {
      me_x=400;
      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (context, position) {
      //     return DemoItem(position,check,menu,comments);
      //   },
      // );

    })
    },

            change(index)

          },


          items: [
            BottomBarWithSheetItem(icon: Icons.menu_book,),
            BottomBarWithSheetItem(icon: Icons.people),
            BottomBarWithSheetItem(icon: Icons.comment),
            BottomBarWithSheetItem(icon: Icons.keyboard_arrow_up),
          ],
        ),

        body:SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 48.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[




            SizedBox(height: 32.0),



            // Center(
            //
            //   child: Text(
            //     _c["type"],
            //
            //     style: Theme.of(c)
            //         .textTheme
            //         .display3
            //         .copyWith(fontFamily: 'rms', color: Colors.amberAccent,fontSize: 30),
            //   ),
            // ),

            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),

            LikeButton(
              size: 80,
              circleColor:
              CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.white,
                  size: 80,
                );
              },
              likeCount: 665,
              countBuilder: (int count, bool isLiked, String text) {
                var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "",
                    style: TextStyle(color: color),
                  );
                } else
                  result = Text(
                    "",
                    style: TextStyle(color: color),
                  );
                return result;
              },
            ),
        ]
        ),


            SizedBox(height: 32.0),
            Center(
              child:Column(
                children: <Widget>[
                  SizedBox(height: 8.0),
                  Padding(

                    padding: EdgeInsets.all(0),
                    child: Image.network(_c["downloadurl"],height: 350,)



              ,


                  ),
                  SizedBox(height: 10.0),
              Visibility(
                visible: false,

                child:Container(

                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new FloatingActionButton(
                            onPressed: add,
                            child: new Icon(Icons.add, color: Colors.black,),
                            backgroundColor: Colors.white,),

                          new Text('$_n',
                              style: new TextStyle(fontSize: 60.0)),

                          new FloatingActionButton(
                            onPressed: minus,
                            child: new Icon(Icons.remove, color: Colors.black,),
                            backgroundColor: Colors.white,),

                        ],
                      ),
                    ),
                  ),
              ),
                  SizedBox(height: 20.0),


                ],
              ),
            ),

            CardSelector(
                cards: _cs.map((c) =>

                    Card(c)).toList(),
                mainCardWidth: _w,
                mainCardHeight: _w * 0.73,
                mainCardPadding: 10.0,
                onChanged: (i) => setState(
                        () =>{
                          _c = _cs[i],
                          viewVisible=false,
                          check=false,
                        _n = 0,
                          num_list=_c["title"],
                          num_list1=_c["description_steps"],

                          print(num_list)

                        }

                )

            ),
            SizedBox(height: 20.0),


          ],
        ),
      ),
    ));
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();
    print("hello");
    Future.delayed(const Duration(milliseconds: 700), () {

// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        showWidget();
      });

    });

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}

class Amounts extends StatelessWidget {
  final Map _c;

  Amounts(this._c);

  @override
  Widget build(BuildContext cx) {

    var tt = Theme.of(cx).textTheme;
    print(tt.caption);

  }
}

class DemoItem extends StatelessWidget {
    final int position;
    final bool check;
    final bool menu;
    final bool comments;

    var num_list=[];
    var num_list1=[];
    var comment_sec=[];





    DemoItem(
      this.position, this.check, this.menu,this.comments, this.num_list, this.num_list1, this.comment_sec,  {
        Key key,
      }) : super(key: key);



  @override
  Widget build(BuildContext context) {
print(menu);
print(comments);

    return Column(
      children: [
    Visibility
      (
        child:ExpansionCard(

          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  num_list[position],
                ),

              ],
            ),
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child:Text(
    num_list1[position]

              )

    ),
    ],
        ),
      visible: menu,

    ),


    Visibility
    (
        child:Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(

                  color: Colors.blue,
                  height: 40.0,
                  width: 40.0,

                ),


                SizedBox(width: 8.0),
                Text(comment_sec[position]),
              ],
            ),

          ],
        ),
      visible: comments,

    ),
        SizedBox(height: 10.0),


      ],
    );
  }
}

class Card extends StatelessWidget {
  final Map _c;

  Card(this._c);

  @override
  Widget build(BuildContext context) {

    var tt = Theme.of(context).textTheme;
    return ClipRRect(

      borderRadius: BorderRadius.circular(12.0),
      child: Container(

        color: Colors.red,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/circles.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),

            Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),

                  Text(_c['recipename'], style: tt.title,),
                  SizedBox(height: 19.0),

                   Text(_c["description"], style: tt.caption,),


                  Expanded(child: Container(
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      // Expanded(
                      //   child: Text(_c['description'],
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, color: Colors.amber, fontSize: 25),
                      //   ),
                      // ),
                      // Image.asset('assets/images/codelliontranswhite.png', width: 48.0),

                    ],
                  ),

                ],

              ),
            ),



          ],
        ),
      ),
    );


  }

}
