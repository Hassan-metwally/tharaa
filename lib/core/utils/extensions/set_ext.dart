part of core;

extension SetExt<E> on Set<E> {
  void replaceWhere(TestListPredicate<E> test, {required E newElement}) {
    final items = toList();
    items.replaceWhere(test, newElement: newElement);
    clear();
    addAll(items);
  }
}
