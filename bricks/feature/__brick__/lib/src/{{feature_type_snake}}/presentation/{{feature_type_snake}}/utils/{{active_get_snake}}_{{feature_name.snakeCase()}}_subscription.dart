import 'package:rxdart/rxdart.dart';

import '../../../../../../../core/core.dart';

class {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription {
  {{active_get_pascal}}{{feature_name.pascalCase()}}Subscription._();

  static final _subject = PublishSubject<NoParams>();

  static void pushUpdate(NoParams params) {
    _subject.add(params);
  }

  static Stream<NoParams> stream() {
    return _subject.stream;
  }
}
