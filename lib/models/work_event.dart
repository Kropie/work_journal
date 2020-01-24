import 'package:work_journal/models/skill.dart';

class WorkEvent {
  String name;
  String description;
  List<Skill> workSkills = [];
  DateTime entryDate;
  bool favorite;
  bool expanded;

  WorkEvent(this.name, this.entryDate,
      {this.description = '', this.favorite = false, this.expanded = false});

  void remove(Skill tag) {
    SkillsDB.instance.removeSkill(tag);
    workSkills.remove(tag);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkEvent &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          workSkills == other.workSkills &&
          entryDate == other.entryDate &&
          favorite == other.favorite &&
          expanded == other.expanded;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      workSkills.hashCode ^
      entryDate.hashCode ^
      favorite.hashCode ^
      expanded.hashCode;
}

class WorkEventDB {
  static WorkEventDB _instance;
  final List<WorkEvent> workEvents = <WorkEvent>[];

  WorkEventDB._internal();

  static WorkEventDB get instance {
    if (_instance == null) {
      _instance = WorkEventDB._internal();
    }

    return _instance;
  }

  void addEvent(WorkEvent event) => workEvents.add(event);

  void updateEvent(WorkEvent event, int index) {
    // This will be necessary when actually connected to a database.
  }

  void removeEvent(WorkEvent event) {
    workEvents.remove(event);
    for (Skill skill in event.workSkills) {
      SkillsDB.instance.removeSkill(skill);
    }
  }

  WorkEvent getEvent(int index) => workEvents[index];

  int get length => workEvents.length;

  List<WorkEvent> getCopy() => List.of(workEvents);
}
