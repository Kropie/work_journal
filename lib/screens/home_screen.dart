import 'package:flutter/material.dart';
import 'package:work_journal/models/filter.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/scaffold_creator.dart';
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
    return ScaffoldCreator.create(
        context,
        "Work Journal",
        WorkEventScreen(_filter),
        _buildFilterFAB(context),
        FloatingActionButton(
          heroTag: "Create event",
          onPressed: () => _addEvent(context),
          child: Icon(Icons.add),
        ));
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
      heroTag: "Filter events",
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
      heroTag: "Filter events",
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
