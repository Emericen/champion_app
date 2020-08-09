import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  double width;
  double height;

  Map size = {
    'welcome_w':0.8,
    'welcome_h':0.065,
    'welcome_f':30.0,

    'error_w': 0.8,
    'error_h': 0.085,
    'error_f':20.0,

    'text_w':0.8,
    'text_h':0.085,

    'space_h':0.025,

    'submit_w':0.6,
    'submit_h':0.07,
    'submit_f':25.0,

    'register_w':0.8,
    'register_h':0.07,
    'register_f':16.0,
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
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
                ), // welcome text
                Container(
                  width: size['error_w'] * width,
                  height: size['error_h'] * height,
                  child: Visibility(
                    visible: showErrorText,
                    child: Center(
                      child: Text(
                        'Incorrect username or password',
                        style: TextStyle(
                          fontSize: size['error_f'],
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ), // error text
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
                ), // username input
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
                ), // password input
                SizedBox(height: size['space_h'] * height),
                Container(
                  width: size['submit_w'] * width,
                  height: size['submit_h'] * height,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        bool result = await connection.login(username, password);
                        if (!result) {
                          enableErrorText();
                        }
                        else if (result) {
                          Navigator.pushReplacementNamed(context, '/home', arguments: {
                            'connection': connection
                          });
                        }
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: size['submit_f'],
                      ),
                    ),
                  ),
                ), // submit button
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
                ), // register switch
              ],
            ),
          ),
        ),
      ),
    );
  }
}
