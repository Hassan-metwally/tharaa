import 'package:rxdart/rxdart.dart';

import '../../../../core/core.dart';

/// [CartItemsCountSubscription] is used for changed log page current tap
/// you can change current log tap from any place
///
class CartItemsCountSubscription {
  CartItemsCountSubscription._();

  static final _subject = PublishSubject<NoParams>();

  static void pushUpdate(NoParams params) {
    _subject.add(params);
  }

  static Stream<NoParams> stream() {
    return _subject.stream;
  }
}
