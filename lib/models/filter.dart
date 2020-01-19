class Filter<T> {
  bool Function(T t) filter;
  String name;

  Filter(this.filter, {this.name = ''});

  bool test(T t) {
    return filter(t);
  }
}
