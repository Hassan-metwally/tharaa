part of 'client_main_page_observer.dart';

class ClientMainPageUpdater {
  ClientMainPageUpdater._();

  static ClientMainPageUpdater? _instance;

  static ClientMainPageUpdater get instance {
    _instance ??= ClientMainPageUpdater._();
    return _instance!;
  }

  final List<ClientMainPageObserver> _observers = [];

  void attachObserver<T>(ClientMainPageObserver observer) {
    _observers.add(observer);
  }

  void deAttachObserver(ClientMainPageObserver observer) {
    _observers.remove(observer);
  }

  static void notifyOnChangedCallbacks(ClientMainPageTabsEnum value) {
    for (var observer in instance._observers) {
      observer.notifyOnChangedCallbacks(value);
    }
  }

  static void dispose() {
    _instance?._observers.clear();
    _instance = null;
  }
}
