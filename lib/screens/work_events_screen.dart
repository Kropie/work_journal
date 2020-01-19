import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_journal/models/filter.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/components/tag_list_widget.dart';
import 'package:collection/collection.dart';

class _WorkEventScreenState extends State<WorkEventScreen> {
  static const _padding = 16.0;
  final List<WorkEvent> _workEvents;
  List<WorkEvent> _previousEvents;
  final Filter<WorkEvent> _filter;
  var count = 0;
  Key key;

  _WorkEventScreenState(this._workEvents, this._filter) {
    _previousEvents = List.of(_workEvents);
    key = Key("$count");
  }

  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> childPanels = [];
    for (var i = 0; i < _workEvents.length; i++) {
      if (_filter.test(_workEvents[i])) {
        childPanels.add(ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) =>
                _buildHeader(
                    context, _isExpanded(_workEvents[i]), _workEvents[i]),
            body: _buildBody(context, _workEvents[i], i),
            isExpanded: _isExpanded(_workEvents[i])));
      }
    }

    Function eq = ListEquality().equals;
    if (_previousEvents.length != _workEvents.length) {
      key = Key("${++count}");
    }
    _previousEvents = List.of(_workEvents);

    var expansionList = ExpansionPanelList(
      key: key,
      expansionCallback: _doExpansion,
      children: childPanels,
    );

    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: expansionList,
      ),
    ));
  }

  bool _isExpanded(final WorkEvent event) {
    if (event == null) {
      return false;
    } else {
      return event.isExpanded;
    }
  }

  void _doExpansion(final int index, final bool isExpanded) {
    setState(() {
      _workEvents[index].isExpanded = !isExpanded;
    });
  }

  Widget _buildBody(
      final BuildContext context, final WorkEvent workEvent, int index) {
    return Container(
      padding: EdgeInsets.all(_padding),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Enter description"),
            controller: TextEditingController(text: workEvent.description),
            maxLines: null,
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.body1,
            onChanged: (change) => workEvent.description = change,
          ),
          TagListWidget(workEvent.workSkills, workEvent),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteWorkEvent(context, index, workEvent)),
          )
        ],
      ),
    );
  }

  void deleteWorkEvent(BuildContext context, int index, WorkEvent workEvent) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          SimpleDialog dialog;
          dialog = SimpleDialog(
            title: Text("Delete this event?"),
            children: <Widget>[
              ButtonBar(children: [
                RaisedButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context, dialog);
                    setState(() {
                      _workEvents.remove(workEvent);
                    });
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, dialog),
                )
              ])
            ],
          );

          return dialog;
        });
  }

  Widget _buildHeader(final BuildContext context, final bool isExpanded,
      final WorkEvent workEvent) {
    IconButton eventTypeIcon;
    IconData iconData;

    if (workEvent.isFavorite) {
      iconData = Icons.favorite;
    } else {
      iconData = Icons.favorite_border;
    }

    eventTypeIcon = IconButton(
      icon: Icon(iconData),
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          workEvent.isFavorite = !workEvent.isFavorite;
        });
      },
    );

    Widget nameWidget = TextField(
      decoration:
          InputDecoration(hintText: "Enter name", border: InputBorder.none),
      controller: TextEditingController(text: workEvent.name),
      style: Theme.of(context).textTheme.body1,
      onChanged: (change) => workEvent.name = change,
    );

    return Row(
      children: <Widget>[
        eventTypeIcon,
        Expanded(
          child: nameWidget,
        ),
        GestureDetector(
          onTap: () => _updateDate(context, workEvent),
          child: Text(
            DateFormat.yMd().format(workEvent.entryDate),
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  void _updateDate(BuildContext context, WorkEvent event) {
    Future<DateTime> selectedDate = showDatePicker(
        context: context,
        initialDate: event.entryDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    selectedDate.then((newDate) => setState(() {
          if (newDate != null) {
            event.entryDate = newDate;
          }
        }));
  }
}

class WorkEventScreen extends StatefulWidget {
  final List<WorkEvent> _workEvent;
  final Filter<WorkEvent> _filter;

  const WorkEventScreen(this._workEvent, this._filter, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WorkEventScreenState(this._workEvent, this._filter);
  }
}
