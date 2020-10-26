import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_test/welcome.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool visitedControl;
  @override
  void initState() {
    super.initState();
    getUserVisiting().then((value){
      visitedControl=value;
      //setUserVisiting();
     setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:visitedControl==false ?WelcomeScreen():HomeScreen() ,
    );
  }
}
Future<bool> getUserVisiting() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool visitedControl = pref.getBool("value2") ?? false;
  return visitedControl;
}

setUserVisiting() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("value2", true);
}
