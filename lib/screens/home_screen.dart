import 'package:flutter/material.dart';

class AddAccomplishmentState extends State<AddAccomplishment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add accomplishment"),
        ),
        body: TextField(maxLines: 8));
  }
}

class AddAccomplishment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddAccomplishmentState();
  }
}
