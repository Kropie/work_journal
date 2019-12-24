import 'package:flutter/material.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/work_event_screen.dart';

class HomeScreenState extends State<HomeScreen> {
  final _events = <WorkEvent>[];
  static const _TITLE = "Work Journal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // Abb bar start.
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.book,
          color: Colors.white,
        ),
        title: Text(
          _TITLE,
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      body: WorkEventScreen(_events),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addEvent(context),
        child: Icon(Icons.add),
      ),
    );
  }

  _addEvent(BuildContext context) {
    setState(() {
      _events.add(WorkEvent("", WorkEventType.accomplishment, DateTime.now()));
    });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
