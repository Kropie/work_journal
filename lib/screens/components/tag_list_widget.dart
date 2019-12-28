import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_journal/models/tag.dart';
import 'package:work_journal/models/work_event.dart';

class TagListWidgetState extends State<TagListWidget> {
  final List<Tag> tagList;
  final WorkEvent parentEvent;

  TagListWidgetState(this.tagList, this.parentEvent);

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
        onTap: () => setState(() {
          Tag newTag = Tag(parentEvent);
          tagList.add(newTag);
          _editTag(context, newTag);
        }),
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

    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5.0,
      children: tagWidgets,
    );
  }

  void _editTag(BuildContext context, Tag tag) {
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
  final List<Tag> tagList;
  final WorkEvent parentEvent;

  TagListWidget(this.tagList, this.parentEvent, {Key key}) : super(key: key);

  @override
  State createState() => TagListWidgetState(tagList, parentEvent);
}
