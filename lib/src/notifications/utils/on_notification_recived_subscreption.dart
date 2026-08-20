import 'package:rxdart/rxdart.dart';

class OnNotificationRecivedSubscription {
  OnNotificationRecivedSubscription._();

  static final _notificationSubject = PublishSubject<int?>();

  static void pushNutificationUpdate(int? orderId) {
    _notificationSubject.add(orderId);
  }

  static Stream<int?> notificationStream() {
    return _notificationSubject.stream;
  }
}
