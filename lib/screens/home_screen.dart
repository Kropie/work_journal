import 'package:flutter/material.dart';
import 'package:work_journal/models/filter.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/work_events_screen.dart';

class _HomeScreenState extends State<HomeScreen> {
  final _events = <WorkEvent>[];
  static const _title = "Work Journal";
  bool showFavorites = false;
  Filter<WorkEvent> _filter;
  Filter<WorkEvent> _favoritesFilter;
  Filter<WorkEvent> _allFilter;
  bool listChanged = false;

  _HomeScreenState() {
    _allFilter = new Filter((WorkEvent e) => true);
    _favoritesFilter =
        new Filter((WorkEvent e) => e.isFavorite, name: "Favorite");

    _filter = new Filter(_allFilter.filter);
  }

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
          leading: Icon(
            Icons.work,
            color: Colors.white,
          ),
          title: Text(
            _title,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        body: workEventScreen,
        floatingActionButton: Container(
            padding: EdgeInsets.only(left: 30),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: _buildFilterFAB(context)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () => _addEvent(context),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            )));
  }

  FloatingActionButton _buildFilterFAB(BuildContext context) {
    if (_filter.name.isEmpty) {
      return _buildFilterStandardFAB(context);
    } else {
      return _buildFilterExtendedFAB(context);
    }
  }

  FloatingActionButton _buildFilterStandardFAB(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: () => {},
      child: PopupMenuButton<Filter<WorkEvent>>(
        onSelected: (Filter<WorkEvent> newFilter) {
          setState(() {
            _filter.filter = newFilter.filter;
            _filter.name = newFilter.name;
          });
        },
        itemBuilder: (context) => [
          PopupMenuItem(value: _favoritesFilter, child: Text("Favorite")),
          PopupMenuItem(value: _allFilter, child: Text("All"))
        ],
        child: Icon(Icons.filter_list),
      ),
      foregroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.foregroundColor,
    );
  }

  FloatingActionButton _buildFilterExtendedFAB(BuildContext context) {
    var iconMenu = _buildFilterMenu(context, Icon(Icons.filter_list));
    var textMenu = _buildFilterMenu(context, Text(_filter.name));

    return FloatingActionButton.extended(
      label: textMenu,
      onPressed: () => {},
      icon: iconMenu,
      foregroundColor:
          Theme.of(context).floatingActionButtonTheme.backgroundColor,
      backgroundColor:
          Theme.of(context).floatingActionButtonTheme.foregroundColor,
    );
  }

  PopupMenuButton _buildFilterMenu(BuildContext context, Widget child) {
    return PopupMenuButton<Filter<WorkEvent>>(
      onSelected: (Filter<WorkEvent> newFilter) {
        setState(() {
          _filter.filter = newFilter.filter;
          _filter.name = newFilter.name;
        });
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: _favoritesFilter, child: Text("Favorite")),
        PopupMenuItem(value: _allFilter, child: Text("All"))
      ],
      child: child,
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
  State<StatefulWidget> createState() => _HomeScreenState();
}
