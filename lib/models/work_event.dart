import 'package:work_journal/models/removable.dart';
import 'package:work_journal/models/tag.dart';

class WorkEvent extends Tagged {
  String name;
  String description;
  List<Tag<WorkEvent>> workSkills = [];
  DateTime entryDate;
  bool favorite;
  bool expanded;

  WorkEvent(this.name, this.entryDate,
      {this.description = '', this.favorite = false, this.expanded = false});

  @override
  void remove(Tag tag) {
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
  List<WorkEvent> workEvents;

  WorkEventDB._internal() {
    workEvents = <WorkEvent>[];
  }

  static WorkEventDB get instance {
    if (_instance == null) {
      _instance = WorkEventDB._internal();
    }

    return _instance;
  }

  void addEvent(WorkEvent toAdd) {
    workEvents.add(toAdd);
  }

  void updateEvent(WorkEvent event, int index) {
    // This will be necessary when actually connected to a database.
  }

  void removeEvent(WorkEvent toRemove) {
    workEvents.remove(toRemove);
  }

  WorkEvent getEvent(int index) {
    return workEvents[index];
  }

  int get length {
    return workEvents.length;
  }

  List<WorkEvent> getCopyOfEvents() {
    return List.of(workEvents);
  }
}
