import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:champion_app/services/database.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Color background = Colors.white;

  final _formKey = GlobalKey<FormState>();
  Map data = {};
  Database connection;

  String username = '';
  String password = '';

  bool showErrorText = false;

  int topFlex = 2;
  int welcomeFlex = 2;
  int warningFlex = 1;
  int textBoxFlex = 2;
  int buttonFlex = 1;
  int registerFlex = 2;
  int bottomFlex = 9;

  void enableErrorText() {
    setState(() {
      showErrorText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data : ModalRoute.of(context).settings.arguments;
    connection = data['connection'];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: background,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: topFlex,
                    child: Container(),
                  ), // TOP
                  Expanded(
                    flex: welcomeFlex,
                    child: Container(
                      child: Center(
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 35
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: warningFlex,
                    child: Visibility(
                      visible: showErrorText,
                      child: Center(
                        child:Text(
                          'Username or password incorrect',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: textBoxFlex,
                    child: Container(
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
                  ), // USERNAME
                  Expanded(
                    flex: textBoxFlex,
                    child: Container(
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
                  ), // PASSWORD
                  Expanded(
                    flex: buttonFlex,
                    child: Container(
                      color: Colors.amber,  // for visualization, remove upon finish
                      child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
//                              print('$username logged in with password $password');



                              }
                            },
                            child: Text('Sign In'),
                          )
                      ),
                    ),
                  ), // BUTTON
                  Expanded(
                    flex: registerFlex,
                    child: Container(
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
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: bottomFlex,
                    child: Container(),
                  ), // BOTTOM
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
