import 'package:flutter/material.dart';

import '../models/client_main_page_tabs_enum.dart';

part "client_main_page_mixin.dart";
part 'client_main_page_updater.dart';

class ClientMainPageObserver<ClientMainPageTabsEnum> {
  final void Function(ClientMainPageTabsEnum tab)? onTabChanged;

  ClientMainPageObserver({this.onTabChanged}) {
    ClientMainPageUpdater.instance.attachObserver(this);
  }

  void dispose() {
    ClientMainPageUpdater.instance.deAttachObserver(this);
  }

  void notifyOnChangedCallbacks(ClientMainPageTabsEnum tab) {
    if (onTabChanged != null) {
      onTabChanged!(tab);
    }
  }
}
