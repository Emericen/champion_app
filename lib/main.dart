import 'package:flutter/material.dart';
import 'package:champion_app/pages/loading.dart';
import 'package:champion_app/services/database.dart';
import 'package:champion_app/pages/register.dart';
import 'package:champion_app/pages/authentication.dart';

void main() async {
  Database connection = await Database();
  runApp(
      MaterialApp(
        home: SignIn(connection: connection),
      )
  );
}
