part of 'client_main_page_observer.dart';

mixin ClientMainPageObserverMixin<T extends StatefulWidget> on State<T> {
  ClientMainPageObserver? mainPageObserver;

  void initObserver<E extends ClientMainPageTabsEnum, K>({void Function(ClientMainPageTabsEnum tab)? onTabChanged}) {
    mainPageObserver = ClientMainPageObserver<ClientMainPageTabsEnum>(onTabChanged: onTabChanged);
  }

  @override
  void dispose() {
    mainPageObserver?.dispose();
    super.dispose();
  }
}
