import 'package:flutter/material.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/work_events_screen.dart';

class HomeScreenState extends State<HomeScreen> {
  final _events = <WorkEvent>[];
  static const _TITLE = "Work Journal";
  bool showFavorites = false;

  @override
  Widget build(BuildContext context) {
    final List<WorkEvent> displayedEvents = _events;
    final WorkEventScreen workEventScreen =
        WorkEventScreen(displayedEvents, _filter);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // Abb bar start.
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.book,
            color: Colors.white,
          ),
          onPressed: () => setState(() {
            if (showFavorites) {
              showFavorites = false;
            } else {
              showFavorites = true;
            }
          }),
        ),
        title: Text(
          _TITLE,
          style: Theme.of(context).textTheme.headline,
        ),
      ),
      body: workEventScreen,
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

  bool _filter(WorkEvent event) {
    if (showFavorites) {
      return event.isFavorite;
    } else {
      return true;
    }
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
