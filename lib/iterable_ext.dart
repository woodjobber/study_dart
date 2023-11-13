extension IterableExtension<T> on Iterable<T> {
  List<T> distinct<U>({required U Function(T t) by}) {
    final unique = <U, T>{};
    for (final item in this) {
      unique.putIfAbsent(by(item), () => item);
    }
    return unique.values.toList();
  }
}

Iterable<E> removeDuplicates<E>(Iterable<E> iterable) sync* {
  Set<E> items = {};
  for (E item in iterable) {
    if (!items.contains(item)) yield item;
    items.add(item);
  }
}
