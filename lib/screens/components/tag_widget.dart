import 'package:flutter/material.dart';
import 'package:work_journal/models/tag.dart';

class TagWidgetState extends State<TagWidget> {
  final Tag tag;

  TagWidgetState({this.tag});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class TagWidget extends StatefulWidget {
  final Tag tag;

  TagWidget(this.tag, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TagWidgetState(tag: tag);
}
