import 'package:flutter/material.dart';
import 'package:champion_app/pages/loading.dart';
import 'package:champion_app/pages/register.dart';
import 'package:champion_app/pages/authentication.dart';
import 'package:champion_app/pages/home.dart';
import 'package:champion_app/pages/selection.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes:{
      '/': (context) => Loading(),
      '/register': (context) => Register(),
      '/signin': (context) => SignIn(),
      '/home': (context) => Home(),
      '/selection': (context) => Selection(),
    },
  ));


//  Map a = {'username': 'eddy', 'owned': ['a', 'b', 'c']};
//  print(a);

//  print("start");
//  Database connection = Database();
//  connection.updateChampionAssets();
//  List<String> ownedChampions = [];
//
//  await connection.registerUser('positino', '680822dd');
//  await connection.registerUser('proveigar', 'qq8072996');
//  await connection.registerUser('niubility', '1234');
//
//  await connection.login('positino', '680822dd');
//  await connection.ownChampion('Vladimir');
//  await connection.ownChampion('Jayce');
//  ownedChampions = await connection.getOwned();
//  print("positino owns $ownedChampions");
//  await connection.logout();
//
//  print('current user ${connection.currentUser}');
//
//  await connection.login('proveigar', 'qq8072996');
//  await connection.ownChampion('Veigar');
//  await connection.ownChampion('Lux');
//  await connection.ownChampion("Kai'Sa");
//  ownedChampions = await connection.getOwned();
//  print("proveigar owns $ownedChampions");
//  await connection.logout();
//
//  print('current user ${connection.currentUser}');
//
//  await connection.login('niubility', '1234');
//  await connection.ownChampion('Malphite');
//  await connection.ownChampion('Ryze');
//  ownedChampions = await connection.getOwned();
//  print("niubility owns $ownedChampions");
//  await connection.logout();
//
//  print('current user ${connection.currentUser}');
//
//  print('finish');

}
