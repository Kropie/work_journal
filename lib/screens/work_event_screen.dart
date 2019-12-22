import 'package:flutter/material.dart';
import 'package:work_journal/models/work_event.dart';

class WorkEventScreenState extends State<WorkEventScreen> {
  WorkEvent workEvent;

  WorkEventScreenState({this.workEvent});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = workEvent.name;
    TextField nameWidget = TextField(
      keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: "Please provide name"),
        style: Theme.of(context).textTheme.title,
        maxLines: null,
        controller: nameController,
        onChanged: (newValue) => workEvent.name = newValue);

    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = workEvent.description;
    TextField descriptionWidget = TextField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          border: InputBorder.none, hintText: "Enter description"),
      style: Theme.of(context).textTheme.body1,
      maxLines: null,
      onChanged: (newDesc) => workEvent.description = newDesc,
      controller: descriptionController,
    );

    return Scaffold(
      appBar: AppBar(
        title: nameWidget,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: descriptionWidget,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Skill"),
        onPressed: () => print("HEY"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class WorkEventScreen extends StatefulWidget {
  final WorkEvent workEvent;

  const WorkEventScreen(this.workEvent, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      WorkEventScreenState(workEvent: this.workEvent);
}
