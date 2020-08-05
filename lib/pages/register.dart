import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Map data = {};
  Database connection;

  final _formKey = GlobalKey<FormState>();
  String username = '';
  String firstPassword = '';
  String password = '';
  bool showErrorText = false;

  Map size = {
    'top_h':0.075,

    'text_w':0.8,
    'text_h':0.085,
    'space_h':0.025,

    'submit_w':0.6,
    'submit_h':0.07,
    'submit_f':25.0,

    'authentication_w':0.8,
    'authentication_h':0.07,
    'authentication_f':16.0
  };


  void enableErrorText() {
    setState(() {
      showErrorText = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;
    connection = data['connection'];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(height:size['top_h'] * height),
                Container(
                  width: size['text_w'] * width,
                  height: size['text_h'] * height,
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter username',
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter username';
                        username = value;
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height:size['space_h'] * height),
                Container(
                  width: size['text_w'] * width,
                  height: size['text_h'] * height,
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter password',
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter password';
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height:size['space_h'] * height),
                Container(
                  width: size['text_w'] * width,
                  height: size['text_h'] * height,
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please confirm password';
                        password = value;
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height:size['space_h'] * height),
                Container(
                  width: size['submit_w'] * width,
                  height: size['submit_h'] * height,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('$username registered with password $password');
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: size['submit_f'],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size['authentication_w'] * width,
                  height: size['authentication_h'] * height,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signin', arguments: {
                        'connection': connection,
                      });
                    },
                    child: Text(
                      "Already have an account? Log in.",
                      style: TextStyle(
                        fontSize: size['authentication_f'],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



