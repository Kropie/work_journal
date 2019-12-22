import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_journal/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Journal',
      home: AddAccomplishment(),
    );
  }
}