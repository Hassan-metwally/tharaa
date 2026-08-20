import 'package:rxdart/rxdart.dart';

import '../../../../../../../core/core.dart';

class {{show_pascal}}{{entity_name.pascalCase()}}DetailSubscription {
  {{show_pascal}}{{entity_name.pascalCase()}}DetailSubscription._();

  static final _subject = PublishSubject<NoParams>();

  static void pushUpdate(NoParams params) {
    _subject.add(params);
  }

  static Stream<NoParams> stream() {
    return _subject.stream;
  }
}

