import 'package:work_journal/models/tag.dart';

abstract class Removable {
  void remove();
}

abstract class TaggedRemovable {
  void remove(Tag tag);
}
