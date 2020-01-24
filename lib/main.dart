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
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          cardColor: Color.fromARGB(255, 25, 25, 25),
          canvasColor: Color.fromARGB(255, 25, 25, 25),
          fontFamily: 'Georgia',
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent,
          ),
          dialogTheme: DialogTheme(
            backgroundColor: Color.fromARGB(255, 25, 25, 25),
            contentTextStyle: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          buttonColor: Colors.redAccent,
          textTheme: TextTheme(
            headline: TextStyle(
                fontFamily: 'Playfair', fontSize: 36.0, color: Colors.white),
            title: TextStyle(fontSize: 18.0, color: Colors.white),
            body1: TextStyle(fontSize: 14.0, color: Colors.white),
            body2: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          )),
    );
  }
}
