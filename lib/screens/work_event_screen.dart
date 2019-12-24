import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/components/tag_widget.dart';

class WorkEventScreenState extends State<WorkEventScreen> {
  List<WorkEvent> workEvents;
  List<bool> _expansionStateList;

  WorkEventScreenState({this.workEvents}) {
    if (workEvents.isEmpty) {
      _expansionStateList = [false];
    } else {
      _expansionStateList = workEvents.map((event) => false).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> childPanels = [];
    for (var i = 0; i < workEvents.length; i++) {
      childPanels.add(ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) =>
              _buildHeader(context, _isExpanded(i), workEvents[i]),
          body: _buildBody(context, workEvents[i]),
          isExpanded: _isExpanded(i)));
    }

    var expansionList = ExpansionPanelList(
      expansionCallback: _doExpansion,
      children: childPanels,
    );
    return SingleChildScrollView(
        child: Container(
      child: expansionList,
    ));
  }

  bool _isExpanded(final int index) {
    if (_expansionStateList.length - 1 < index) {
      _expansionStateList.add(false);
    }
    return _expansionStateList[index];
  }

  void _doExpansion(final int index, final bool isExpanded) {
    setState(() {
      _expansionStateList[index] = !isExpanded;
      _buildHeader(context, isExpanded, workEvents[index]);
    });
  }

  Widget _buildBody(final BuildContext context, final WorkEvent workEvent) {
    final descriptionEditor = TextField(
      decoration: InputDecoration(hintText: "Enter description"),
      controller: TextEditingController(text: workEvent.description),
      maxLines: null,
      style: Theme.of(context).textTheme.body1,
      onChanged: (change) => workEvent.description = change,
    );

    final tagEditors = <Widget>[];
    workEvent.workSkills.forEach((tag) => tagEditors.add(TagWidget(tag)));
    final tagEditorRow = Row(children: tagEditors);

    return Container(
      child: Column(
        children: <Widget>[descriptionEditor, tagEditorRow],
      ),
    );
  }

  Widget _buildHeader(final BuildContext context, final bool isExpanded,
      final WorkEvent workEvent) {
    Icon eventTypeIcon;

    switch (workEvent.eventType) {
      case WorkEventType.accomplishment:
        eventTypeIcon = Icon(
          Icons.star,
          color: Theme.of(context).accentColor,
        );
        break;
      case WorkEventType.journalEntry:
      default:
        eventTypeIcon = Icon(Icons.bookmark);
    }

    Widget nameWidget = TextField(
      decoration: InputDecoration(
          prefixIcon: eventTypeIcon,
          hintText: "Enter name",
          suffixText: DateFormat.yMd().format(workEvent.entryDate),
          border: InputBorder.none),
      controller: TextEditingController(text: workEvent.name),
      style: Theme.of(context).textTheme.body1,
      onChanged: (change) => workEvent.name = change,
    );

    return nameWidget;
  }
}

class WorkEventScreen extends StatefulWidget {
  final List<WorkEvent> workEvent;

  const WorkEventScreen(this.workEvent, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      WorkEventScreenState(workEvents: this.workEvent);
}
