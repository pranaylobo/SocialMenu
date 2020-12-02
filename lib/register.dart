import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

void main() {
  runApp(register());
}

class register extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Registration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String selectedRole = "Writer";
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  final name = TextEditingController();
  final number = TextEditingController();
  final address = TextEditingController();
  final blood_type = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final c_password = TextEditingController();
  final medical = TextEditingController();
  final age = TextEditingController();
  String blood_type_get;
  final databaseReference = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    final List<CoolStep> steps = [

      CoolStep(
        title: "Register your self",
        subtitle: "Enter your email address and create a password",
        content: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),

              TextField(
                controller: name,

                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Full Name",
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: number,

                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Phone Number",
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: email,

                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Email Address",
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: password,
                obscureText: true,

                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Password",
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: c_password,

                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Confirm Password",
                    fillColor: Colors.white70),
              ),


            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("Steps completed!");


        add_details(name.text,number.text,email.text,password.text,c_password.text);

      },
      steps: steps,
      config: CoolStepperConfig(
        backText: "PREV",
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }

  Widget _buildTextField({
    String labelText,
    FormFieldValidator<String> validator,
    TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildSelector({
    BuildContext context,
    String name,
  }) {
    bool isActive = name == selectedRole;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedRole,
          onChanged: (String v) {
            setState(() {
              selectedRole = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  void add_details(String name, String number,  String email, String pass, String c_pass)async {
    await databaseReference.collection("User Details")
        .document(email)
        .setData({
      'name':name,
      'number':number,
      'email':email,


    });

    print("document writtern");

    signUp(email,pass);


  }
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => login()),
    );

  }
}