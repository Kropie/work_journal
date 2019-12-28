import 'package:work_journal/models/removable.dart';
import 'package:work_journal/models/tag.dart';

class WorkEvent extends Tagged {
  String name;
  String description;
  WorkEventType eventType;
  List<Tag<Tagged>> workSkills = [];
  DateTime entryDate;
  bool isFavorite;

  WorkEvent(this.name, this.eventType, this.entryDate,
      {this.description = '', this.isFavorite = false});

  @override
  void remove(Tag tag) {
    workSkills.remove(tag);
  }
}

enum WorkEventType { accomplishment, journalEntry }
