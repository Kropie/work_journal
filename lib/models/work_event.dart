class WorkEvent {
  String name;
  String description;
  WorkEventType eventType;
  List<WorkSkills> workSkills;
  DateTime entryDate;

  WorkEvent(this.name, this.eventType, this.entryDate,
      {this.description = '', this.workSkills = const []});
}

class WorkSkills {
  String name;

  WorkSkills(this.name);
}

enum WorkEventType { accomplishment, journalEntry, milestone }
