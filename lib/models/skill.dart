import 'package:work_journal/models/work_event.dart';

class Skill {
  WorkEvent _parent;
  String _name;
  bool workingCopy = true;

  Skill(this._parent, {String name}) : _name = name {
    SkillsDB.instance.addSkill(this);
  }

  Skill.workingCopy(this._name) {
    workingCopy = true;
  }

  String get name => _name;

  set name(String name) {
    if (!workingCopy && name != _name) {
      String temp = _name;
      _name = name;

      SkillsDB.instance._evaluateName(this, temp, name);
    } else {
      this._name = name;
    }
  }

  void remove() => this._parent.remove(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Skill &&
          runtimeType == other.runtimeType &&
          _parent == other._parent &&
          _name == other._name;

  @override
  int get hashCode => _parent.hashCode ^ _name.hashCode;
}

class SkillsDB {
  static SkillsDB _instance;
  final Map<String, List<Skill>> skillsMap = Map();

  SkillsDB._internal();

  static SkillsDB get instance {
    if (_instance == null) {
      _instance = SkillsDB._internal();
    }

    return _instance;
  }

  void _evaluateName(Skill skill, String newName, String oldName) {
    removeSkill(Skill.workingCopy(oldName));
    addSkill(skill);
  }

  void addSkill(Skill skill) {
    if (skillsMap[skill.name] == null) {
      skillsMap[skill.name] = <Skill>[];
    }

    skillsMap[skill.name].add(skill);
  }

  void removeSkill(Skill skill) {
    if (skillsMap.containsKey(skill.name)) {
      skillsMap[skill.name].remove(skill);
      if (skillsMap[skill.name].isEmpty) {
        skillsMap.remove(skill.name);
      }
    }
  }

  ///
  /// Gets a working copy of the skills that are currently available, avoiding
  /// any names provided in the [excludedNames] list, if provided.
  ///
  List<Skill> getWorkingCopy({List<String> excludedNames}) {
    List<Skill> copy = <Skill>[];

    for (String name in skillsMap.keys) {
      if (excludedNames != null && !excludedNames.contains(name)) {
        copy.add(Skill.workingCopy(name));
      }
    }

    copy.sort((a, b) => a.name.compareTo(b.name));
    return copy;
  }
}
