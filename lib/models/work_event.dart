import 'package:work_journal/models/removable.dart';
import 'package:work_journal/models/tag.dart';

class WorkEvent extends Tagged {
  String name;
  String description;
  WorkEventType eventType;
  List<Tag<Tagged>> workSkills = [];
  DateTime entryDate;
  bool isFavorite;
  bool isExpanded;

  WorkEvent(this.name, this.eventType, this.entryDate,
      {this.description = '',
      this.isFavorite = false,
      this.isExpanded = false});

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
          eventType == other.eventType &&
          workSkills == other.workSkills &&
          entryDate == other.entryDate &&
          isFavorite == other.isFavorite &&
          isExpanded == other.isExpanded;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      eventType.hashCode ^
      workSkills.hashCode ^
      entryDate.hashCode ^
      isFavorite.hashCode ^
      isExpanded.hashCode;
}

enum WorkEventType { accomplishment, journalEntry }
