import 'package:rxdart/rxdart.dart';

import '../../../../../../../../core/core.dart';

class GetStatisticsSubscription {
  GetStatisticsSubscription._();

  static final _subject = PublishSubject<NoParams>();

  static void pushUpdate(NoParams params) {
    _subject.add(params);
  }

  static Stream<NoParams> stream() {
    return _subject.stream;
  }
}
