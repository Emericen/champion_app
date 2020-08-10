import 'package:champion_app/services/transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:champion_app/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:champion_app/pages/home.dart';
import 'package:champion_app/pages/register.dart';

class SignIn extends StatefulWidget {
  final Database connection;
  SignIn({this.connection});

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
    'register_f':16.0,
  };
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool showLoading = false;

  void toggleLoadingIcon() {
    setState((){
      showLoading = !showLoading;
    });
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Incorrect username or password'),
          actions: <Widget>[
            FlatButton(
              child: Text('Return'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  width: size['welcome_w']* width,
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
                        toggleLoadingIcon();
                        bool result = await widget.connection.login(username, password);
                        if (!result) {
                          toggleLoadingIcon();
                          await _showErrorDialog();
                        }
                        else if (result) {
                          toggleLoadingIcon();
                          Navigator.pushReplacement(
                            context,
                            EnterExitRoute(
                              thisPage: this.widget,
                              nextPage: Home(connection: widget.connection),
                              newPageDirection: Offset(0,-1)
                            )
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: <Widget>[
                        Visibility(
                          visible: !showLoading,
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size['submit_f'],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: showLoading,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    )
                  ),
                ), // submit button
                Container(
                  width: size['register_w'] * width,
                  height: size['register_h'] * height,
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        EnterExitRoute(
                          thisPage: this.widget,
                          nextPage: Register(connection: widget.connection),
                          newPageDirection: Offset(1, 0)
                        )
                      );
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



