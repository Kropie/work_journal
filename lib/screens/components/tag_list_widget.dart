import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_journal/models/skill.dart';
import 'package:work_journal/models/work_event.dart';
import 'package:work_journal/screens/components/add_skill.dart';

class _TagListWidgetState extends State<TagListWidget> {
  final List<Skill> tagList;
  final WorkEvent parentEvent;

  _TagListWidgetState(this.tagList, this.parentEvent);

  @override
  Widget build(BuildContext context) {
    if (tagList == null) {
      return Container();
    }

    var tagWidgets = <Widget>[
      GestureDetector(
        child: Chip(
          backgroundColor: Theme.of(context).textTheme.body1.color,
          label: Text(
            "Add Skill",
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Theme.of(context).accentColor),
          ),
          avatar: CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Theme.of(context).textTheme.body1.color,
            child: Icon(Icons.add),
          ),
        ),
        onTap: () =>
            showDialog(context: context, child: AddSkillDialog(parentEvent))
                .then((value) => setState(() {})),
      )
    ];

    tagWidgets.addAll(tagList.map((tag) {
      return GestureDetector(
        onTap: () => _editTag(context, tag),
        child: Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text(tag.name),
          onDeleted: () {
            setState(() {
              tag.remove();
            });
          },
        ),
      );
    }));

    return Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5.0,
          children: tagWidgets,
        ));
  }

  void _editTag(BuildContext context, Skill tag) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          SimpleDialog dialog;
          dialog = SimpleDialog(
            backgroundColor: Theme.of(context).cardColor,
            title: Text("Edit skill"),
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    autofocus: true,
                    controller: TextEditingController(text: tag.name),
                    onChanged: (newValue) {
                      setState(() {
                        tag.name = newValue;
                      });
                    },
                    onSubmitted: (change) => Navigator.pop(context, dialog),
                  )),
            ],
          );

          return dialog;
        });
  }
}

class TagListWidget extends StatefulWidget {
  final List<Skill> tagList;
  final WorkEvent parentEvent;

  TagListWidget(this.tagList, this.parentEvent, {Key key}) : super(key: key);

  @override
  State createState() => _TagListWidgetState(tagList, parentEvent);
}
