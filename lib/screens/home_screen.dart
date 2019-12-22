import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/work_event_screen.dart';

class HomeScreenState extends State<HomeScreen> {
  final _events = <WorkEvent>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Work Journal",
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      body: _buildEventWidgets(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addEvent(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventWidgets() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: _buildEventRow,
      itemCount: _events.length,
    );
  }

  Widget _buildEventRow(BuildContext context, int i) {
    final evt = _events[i];

    var respondToTap = () => _openEventScreen(context, _events[i]);

    return ListTile(
      title: Column(
        children: <Widget>[
          Text(evt.name),
          Text(
            new DateFormat.yMd().format(evt.entryDate),
            style: Theme.of(context).textTheme.body2,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      leading: Icon(
        Icons.star,
        color: Colors.blue,
      ),
      onTap: respondToTap,
    );
  }

  void _addEvent(BuildContext context) {
    setState(() {
      final evt = WorkEvent(
          "", WorkEventType.accomplishment, DateTime.now());
      _events.add(evt);
      _openEventScreen(context, evt);
    });
  }

  void _openEventScreen(BuildContext context, WorkEvent event) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => WorkEventScreen(event)));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
