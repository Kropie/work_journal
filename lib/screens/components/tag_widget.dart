import 'package:flutter/material.dart';
import 'package:work_journal/models/tag.dart';

class TagWidgetState extends State<TagWidget> {
  final Tag tag;

  TagWidgetState({this.tag});

  @override
  Widget build(BuildContext context) {
    final editorController = TextEditingController(text: this.tag.name);
    final editor = TextField(
      // decoration: InputDecoration(
      //     border: OutlineInputBorder(
      //         borderRadius: BorderRadius.all(const Radius.circular(10.0)))),
      // style: Theme.of(context).textTheme.body1.copyWith(color: Colors.yellow),
      // maxLength: 3,
      controller: editorController,
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: editor,
        ),
        Expanded(child: Icon(Icons.cancel))
      ],
    );
  }
}

class TagWidget extends StatefulWidget {
  final Tag tag;

  TagWidget(this.tag, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TagWidgetState(tag: tag);
}
