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

  String username = '';
  String password = '';

  bool showErrorText = false;

  int topFlex = 3;
  int textBoxFlex = 2;
  int buttonFlex = 1;
  int warningFlex = 1;
  int bottomFlex = 9;

  void enableErrorText() {
    setState(() {
      showErrorText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
