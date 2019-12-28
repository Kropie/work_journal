import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/components/tag_list_widget.dart';

class WorkEventScreenState extends State<WorkEventScreen> {
  static const _padding = 16.0;
  final List<WorkEvent> workEvents;
  List<bool> _expansionStateList;
  List<WorkEvent> _favoriteWorkEvents;
  final bool Function(WorkEvent event) filter;

  WorkEventScreenState(this.workEvents, this.filter) {
    if (workEvents.isEmpty) {
      _expansionStateList = [false];
    } else {
      _expansionStateList = workEvents.map((event) => false).toList();
    }

    _favoriteWorkEvents = [];
    for (var value in workEvents) {
      if (value.isFavorite) _favoriteWorkEvents.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ExpansionPanel> childPanels = [];
    for (var i = 0; i < workEvents.length; i++) {
      if (filter(workEvents[i])) {
        childPanels.add(ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) =>
                _buildHeader(context, _isExpanded(i), workEvents[i]),
            body: _buildBody(context, workEvents[i]),
            isExpanded: _isExpanded(i)));
      }
    }

    var expansionList = ExpansionPanelList(
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
    return Container(
      padding: EdgeInsets.all(_padding),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Enter description"),
            controller: TextEditingController(text: workEvent.description),
            maxLines: null,
            keyboardType: TextInputType.text,
            style: Theme
                .of(context)
                .textTheme
                .body1,
            onChanged: (change) => workEvent.description = change,
          ),
          TagListWidget(workEvent.workSkills, workEvent)
        ],
      ),
    );
  }

  Widget _buildHeader(final BuildContext context, final bool isExpanded,
      final WorkEvent workEvent) {
    IconButton eventTypeIcon;
    IconData iconData;

    if (_favoriteWorkEvents.contains(workEvent)) {
      iconData = Icons.favorite;
    } else {
      iconData = Icons.favorite_border;
    }

    

    eventTypeIcon = IconButton(
      icon: Icon(iconData),
      color: Theme
          .of(context)
          .accentColor,
      onPressed: () {
        setState(() {
          if (!_favoriteWorkEvents.remove(workEvent)) {
            _favoriteWorkEvents.add(workEvent);
            workEvent.isFavorite = true;
          }
        });
      },
    );

    Widget nameWidget = TextField(
      decoration:
      InputDecoration(hintText: "Enter name", border: InputBorder.none),
      controller: TextEditingController(text: workEvent.name),
      style: Theme
          .of(context)
          .textTheme
          .body1,
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
            style: Theme
                .of(context)
                .textTheme
                .caption,
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

    selectedDate.then((newDate) =>
        setState(() {
          if (newDate != null) {
            event.entryDate = newDate;
          }
        }));
  }
}

class WorkEventScreen extends StatefulWidget {
  final List<WorkEvent> workEvent;
  final bool Function(WorkEvent event) filter;

  const WorkEventScreen(this.workEvent, this.filter, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      WorkEventScreenState(this.workEvent, this.filter);
}
