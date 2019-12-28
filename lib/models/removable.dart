import 'package:work_journal/models/tag.dart';

abstract class Removable {
  void remove();
}

abstract class Tagged {
  void remove(Tag tag);
}
