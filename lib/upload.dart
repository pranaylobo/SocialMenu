import 'package:flutter/material.dart';
import 'package:flutter_app/recipeimage.dart';
import 'package:nice_button/nice_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(upload());
}

class upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(children: [
          // Image.asset(
          //   "assets/images/confetti.gif",
          //   height: 125.0,
          //   width: 125.0,
          // )

          Container(
            height:500,

            child:Image.network('https://firebasestorage.googleapis.com/v0/b/teamkalm-29130.appspot.com/o/demo%2Fabc.gif?alt=media&token=e1abe573-b6dd-4742-aeb9-607f7af15d51',fit: BoxFit.cover,
            ),

          ),
          SizedBox(
            height: 20.0,
          ),
          NiceButton(
            width: 190,
            elevation: 8.0,
            text: "Add Recipe Details",fontSize: 15,
            background: Colors.red,
            onPressed: () async {
              List<PersonEntry> persons = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SOF(),
                ),
              );
              if (persons != null) persons.forEach(print);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          NiceButton(
              width: 150,
              elevation: 8.0,
              text: "Add Recipe Image",fontSize: 15,
              background: Colors.blue,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadingImageToFirebaseStorage()),
                )


              }


          ),
        ],)


        // child: RaisedButton(
        //
        //   child:
        //   Text('Add entries'),
        //   onPressed: () async {
        //     List<PersonEntry> persons = await Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => SOF(),
        //       ),
        //     );
        //     if (persons != null) persons.forEach(print);
        //   },
        // ),
      ),
    );
  }
}

class SOF extends StatefulWidget {
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  var nameTECs = <TextEditingController>[];
  var ageTECs = <TextEditingController>[];
  var jobTECs = <TextEditingController>[];
  var recipe = <TextEditingController>[];
  var recipename = TextEditingController();
  var description123 = TextEditingController();


  var cards = <Card>[];
  bool check =true;
  final databaseReference = Firestore.instance;

  List l = [];
  List l1 = [];

  Card createCard() {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var jobController = TextEditingController();

    nameTECs.add(nameController);
    ageTECs.add(ageController);
    jobTECs.add(jobController);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: check,
            child:  TextField(
                controller: recipename,

                decoration: InputDecoration(labelText: 'Recipe Title')),
          ),
          Visibility(
            visible: check,
            child:  TextField(
                controller: description123,

                decoration: InputDecoration(labelText: 'Recipe Description')),
          ),

          TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Step Title')),
          TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Step Description')),
          // TextField(
          //     controller: jobController,
          //     decoration: InputDecoration(labelText: 'Study/ job')),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onDone() {
    List<PersonEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var name = nameTECs[i].text;
      var age = ageTECs[i].text;
      var job = jobTECs[i].text;
      var rec = recipename.text;
      var dec= description123.text;

      l.add(name);
      l1.add(age);

      add_details(l,l1,rec,dec);

      print(l);
      print(l1);


      entries.add(PersonEntry(name, age, job));
    }
    Navigator.pop(context, entries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Your Recipe"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NiceButton(
              width: 150,
              elevation: 8.0,
              text: "Add Next Step",fontSize: 15,
              background: Colors.amber,
              onPressed: () => {

                setState(() => cards.add(createCard())),
                setState(() =>

check=false
                ),


              }


            ),


            // child: RaisedButton(
            //   child: Text('add new'),
            //   onPressed: () => setState(() => cards.add(createCard())),
            // ),
          ),



        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    );
  }

  void add_details(List l, List l1, text, String dec)async {

    await databaseReference.collection("Recipe")
        .document(text)
        .setData({
      'title':l,
      'description':dec,
      'description_steps':l1,
      "recipename":text,

    });

    print("document writtern");
  }
}

class PersonEntry {
  final String name;
  final String age;
  final String studyJob;

  PersonEntry(this.name, this.age, this.studyJob);



  @override
  String toString() {


    return 'Person: name= $name, age= $age, study job= $studyJob';
  }
}