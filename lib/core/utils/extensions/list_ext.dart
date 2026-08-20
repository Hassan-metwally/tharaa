part of core;

typedef ElementIndexedMapper<T, E> = T Function(E element, int index);
typedef TestListPredicate<E> = bool Function(E e);

extension ListExt<E> on List<E> {
  E? firstWhereOrNull(bool Function(E e) test, {E Function()? orElse}) {
    try {
      return firstWhere(test, orElse: orElse);
    } catch (e) {
      return null;
    }
  }

  List<T> mapIndexed<T>(ElementIndexedMapper<T, E> mapper) {
    final list = <T>[];
    for (int i = 0; i < length; i++) {
      list.add(mapper(this[i], i));
    }
    return list;
  }

  int? firstIndexWhere(TestListPredicate<E> test) {
    final index = indexWhere((element) => test(element));
    if (index == -1) {
      return null;
    } else {
      return index;
    }
  }

  void replaceWhere(TestListPredicate<E> test, {required E newElement}) {
    final index = firstIndexWhere(test);
    if (index != null) {
      this[index] = newElement;
    } else {
      add(newElement);
    }
  }
}
