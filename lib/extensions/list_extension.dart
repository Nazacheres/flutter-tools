extension ListExtensions<T> on List<T> {
  /// Adds the [value] between all elements in the list
  void addBetweenAll(T value) {
    for (int i = length - 1; i > 0; i--) {
      insert(i, value);
    }
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}