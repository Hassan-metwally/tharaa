import '../../../core/core.dart';

enum ClientMainPageTabsEnum {
  home,
  orders,
  cart,
  more;

  String get filledIc {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return "";
      case ClientMainPageTabsEnum.orders:
        return "";
      case ClientMainPageTabsEnum.cart:
        return "";
      case ClientMainPageTabsEnum.more:
        return "";
    }
  }

  String get outlineIc {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return "";
      case ClientMainPageTabsEnum.orders:
        return "";
      case ClientMainPageTabsEnum.cart:
        return "";
      case ClientMainPageTabsEnum.more:
        return "";
    }
  }

  String get title {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return appLocalizer.home;
      case ClientMainPageTabsEnum.orders:
        return appLocalizer.orders;
      case ClientMainPageTabsEnum.cart:
        return appLocalizer.cart;
      case ClientMainPageTabsEnum.more:
        return appLocalizer.more;
    }
  }
}
