import 'package:flutter/material.dart';
import 'package:work_journal/screens/scaffold_creator.dart';

import '../models/filter.dart';
import '../models/skill.dart';
import '../models/work_event.dart';
import 'work_events_screen.dart';

class SkillsScreen extends StatefulWidget {
  SkillsScreen(Key key) : super(key: key);

  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  List<bool> _expansionList =
      SkillsDB.instance.getWorkingCopy().map((s) => false).toList();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCreator.create(
        context,
        "Work Journal",
        SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: ExpansionPanelList(
              children: createSkillsExpansionPanels(context),
              expansionCallback: (i, e) => setState(() {
                _expansionList[i] = !e;
              }),
            ),
          ),
        )),
        null,
        null);
  }

  List<ExpansionPanel> createSkillsExpansionPanels(BuildContext context) {
    var childPanels = <ExpansionPanel>[];
    var headerBuilder = (BuildContext c, Skill skill) {
      // Ignore the expanded state for the header builder.
      return Chip(
        backgroundColor: Theme.of(c).accentColor,
        label: Text(skill.name),
      );
    };

    var bodyBuilder = (Skill skill) {
      return WorkEventScreen(Filter<WorkEvent>((WorkEvent e) {
        return e.workSkills.map((Skill s) => s.name).contains(skill.name);
      }));
    };

    var counter = 0;
    for (var skill in SkillsDB.instance.getWorkingCopy()) {
      childPanels.add(ExpansionPanel(
          headerBuilder: (var context, var exp) {
            return headerBuilder(context, skill);
          },
          body: bodyBuilder(skill),
          isExpanded: _expansionList[counter++]));
    }

    return childPanels;
  }
}
