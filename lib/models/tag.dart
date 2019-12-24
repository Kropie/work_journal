import 'package:work_journal/models/removable.dart';

class Tag<T extends TaggedRemovable> extends Removable {
  T parent;
  String name;
  Tag(this.parent, {this.name = ""});

  @override
  void remove() => this.parent.remove(this);
}
