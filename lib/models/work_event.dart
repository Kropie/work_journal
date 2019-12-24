import 'package:work_journal/models/removable.dart';
import 'package:work_journal/models/tag.dart';

class WorkEvent extends TaggedRemovable {
  String name;
  String description;
  WorkEventType eventType;
  List<Tag<WorkEvent>> workSkills;
  DateTime entryDate;

  WorkEvent(this.name, this.eventType, this.entryDate,
      {this.description = '', this.workSkills = const []});

  @override
  void remove(Tag tag) {
    workSkills.remove(tag);
  }
}

enum WorkEventType { accomplishment, journalEntry }
