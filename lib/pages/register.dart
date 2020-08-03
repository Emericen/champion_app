import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Color background = Colors.white;

  final _formKey = GlobalKey<FormState>();

  Map data = {};
  Database connection;

  String username = '';
  String firstPassword = '';
  String password = '';

  bool showErrorText = false;

  int topFlex = 3;
  int textBoxFlex = 2;
  int buttonFlex = 1;
  int warningFlex = 1;
  int authenticationFlex = 1;
  int bottomFlex = 8;

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
                          firstPassword = value;
                          return null;
                        },
                        obscureText: true,
                      ),
                    ),
                  ), // PASSWORD
                  Expanded(
                    flex: textBoxFlex,
                    child: Container(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Confirm password',
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please confirm password';
                          else if (value != firstPassword)
                            return 'Please enter the same password';
                          password = value;
                          return null;
                        },
                        obscureText: true,
                      ),
                    ),
                  ),
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
//                                print('$username signed up with password $password');


                              }
                            },
                            child: Text('Sign Up'),
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
                          'Username already exist.',
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
                    flex: authenticationFlex,
                    child: Container(
                      color: Colors.green,
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



