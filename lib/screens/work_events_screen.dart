import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_journal/models/filter.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/components/tag_list_widget.dart';

class _WorkEventScreenState extends State<WorkEventScreen> {
  static const _padding = 16.0;
  int _previousLength = 0;
  String _previousFilterName = "";
  final Filter<WorkEvent> _filter;
  final WorkEventDB db = WorkEventDB.instance;
  var count = 0;
  Key key;

  _WorkEventScreenState(this._filter) {
    key = Key("$count");
  }

  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> childPanels = [];
    for (var i = 0; i < WorkEventDB.instance.length; i++) {
      if (_filter.test(WorkEventDB.instance.getEvent(i))) {
        childPanels.add(ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) =>
                _buildHeader(
                    context, _isExpanded(db.getEvent(i)), db.getEvent(i)),
            body: _buildBody(context, db.getEvent(i), i),
            isExpanded: _isExpanded(db.getEvent(i))));
      }
    }

    if (_previousLength != db.length || _previousFilterName != _filter.name) {
      key = Key("${this.runtimeType}_${_filter.name}_${++count}");
    }
    _previousLength = db.length;
    _previousFilterName = _filter.name;

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
      return event.expanded;
    }
  }

  void _doExpansion(final int index, final bool expanded) {
    setState(() {
      db.getEvent(index).expanded = !expanded;
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
                      db.removeEvent(workEvent);
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

    if (workEvent.favorite) {
      iconData = Icons.favorite;
    } else {
      iconData = Icons.favorite_border;
    }

    eventTypeIcon = IconButton(
      icon: Icon(iconData),
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          workEvent.favorite = !workEvent.favorite;
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
  final Filter<WorkEvent> _filter;

  const WorkEventScreen(this._filter, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WorkEventScreenState(this._filter);
  }
}
