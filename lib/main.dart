import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_journal/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Journal',
      home: HomeScreen(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 36.0, color: Colors.white),
            title: TextStyle(fontSize: 18.0, color: Colors.white),
            body1: TextStyle(
              fontSize: 14.0,
            ),
            body2: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic),
          )),
    );
  }
}
