import 'package:flutter/material.dart';
import 'package:work_journal/models/object_wrapper.dart';
import 'package:work_journal/models/skill.dart';
import 'package:work_journal/models/work_event.dart';

class AddSkillDialog extends StatefulWidget {
  final WorkEvent _workEvent;

  AddSkillDialog(this._workEvent);

  @override
  _AddSkillDialogState createState() => _AddSkillDialogState(_workEvent);
}

class _AddSkillDialogState extends State<AddSkillDialog> {
  final WorkEvent _workEvent;
  final SkillsDB db = SkillsDB.instance;
  List<Skill> availableSkills;
  final Skill inWorkSkill = Skill.workingCopy("");
  ObjectWrapper<Skill> skillWrapper;
  TextEditingController nameController = new TextEditingController(text: "");

  _AddSkillDialogState(this._workEvent) {
    skillWrapper = ObjectWrapper(value: inWorkSkill);
    List<String> usedNames = _workEvent.workSkills.map((s) => s.name).toList();
    availableSkills = db.getWorkingCopy(excludedNames: usedNames);
  }

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      setState(() {
        inWorkSkill.name = nameController.text;

        skillWrapper.value = inWorkSkill;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SimpleDialog dialog;

    dialog = SimpleDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text("Add skill"),
      children: <Widget>[
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Enter name"),
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.body1,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      children: availableSkills
                          .map((s) => getSkillChip(context, s))
                          .toList(),
                    ))
              ],
            ),
          ),
        ),
        ButtonBar(
          children: _getDialogButtons(
              context,
              dialog,
              _workEvent,
              skillWrapper.value,
              _workEvent.workSkills.map((s) => s.name).toList()),
        )
      ],
    );

    return dialog;
  }

  GestureDetector getSkillChip(BuildContext context, Skill skill) {
    return GestureDetector(
        child: Chip(
          backgroundColor: Theme.of(context).accentColor,
          label: Text(
            skill.name ?? "",
          ),
        ),
        onTap: () => setState(() {
              skillWrapper.value = skill;
            }));
  }

  List<Widget> _getDialogButtons(BuildContext context, SimpleDialog dialog,
      WorkEvent event, Skill skill, List<String> usedSkillNames) {
    List<Widget> buttons = <Widget>[];

    bool canAdd = skill != null &&
        skill.name.isNotEmpty &&
        !usedSkillNames.contains(skill.name);

    if (canAdd) {
      buttons.add(RaisedButton(
        child: Text("Add ${skill.name}"),
        onPressed: () {
          setState(() {
            event.workSkills.add(Skill(event, name: skill.name));
            Navigator.pop(context, dialog);
          });
        },
      ));
    }

    buttons.add(FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, dialog);
        SkillsDB.instance.removeSkill(skill);
      },
    ));

    return buttons;
  }
}
