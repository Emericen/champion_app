import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  Map size = {
    'welcome_w':0.8,
    'welcome_h':0.15,
    'welcome_f':30.0,

    'text_w':0.8,
    'text_h':0.085,

    'space_h':0.025,

    'submit_w':0.6,
    'submit_h':0.07,
    'submit_f':25.0,

    'register_w':0.8,
    'register_h':0.07,
    'register_f':16.0
  };

  Map data = {};
  final _formKey = GlobalKey<FormState>();
  Database connection;

  String username = '';
  String password = '';
  bool showErrorText = false;

  void enableErrorText() {
    setState(() {
      showErrorText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;
    connection = data['connection'];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                SizedBox(height: size['space_h'] * height),
                Container(
                  width: size['welcome_w'] * width,
                  height: size['welcome_h'] * height,
                  child: Center(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: size['welcome_f'],
                      ),
                    ),
                  ),
                ),
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
                SizedBox(height: size['space_h'] * height),
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
                        password = value;
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: size['space_h'] * height),
                Container(
                  width: size['submit_w'] * width,
                  height: size['submit_h'] * height,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print('$username logged in with password $password');
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: size['submit_f'],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size['register_w'] * width,
                  height: size['register_h'] * height,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register', arguments: {
                        'connection': connection,
                      });
                    },
                    child: Text(
                      "Don't have an account? Sign up.",
                      style: TextStyle(
                        fontSize: size['register_f'],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
