import 'package:flutter/material.dart';
import 'package:work_journal/models/filter.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/work_events_screen.dart';

class _HomeScreenState extends State<HomeScreen> {
  static const _title = "Work Journal";
  bool showFavorites = false;
  Filter<WorkEvent> _filter;
  Filter<WorkEvent> _favoritesFilter;
  Filter<WorkEvent> _allFilter;
  bool listChanged = false;

  _HomeScreenState() {
    _allFilter = new Filter((WorkEvent e) => true);
    _favoritesFilter =
        new Filter((WorkEvent e) => e.favorite, name: "Favorite");

    _filter = new Filter(_allFilter.filter);
  }

  @override
  Widget build(BuildContext context) {
    final WorkEventScreen workEventScreen = WorkEventScreen(_filter);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text("JK"),
                    backgroundColor: Theme.of(context).textTheme.body1.color,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  Text("TODO - Show user info")
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.work,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Accomplishments",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.build,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Skills",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
            )
          ],
        )),
        appBar: AppBar(
          centerTitle: true,
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
      WorkEventDB.instance.addEvent(WorkEvent("", DateTime.now()));
    });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}
