import '../../../core/core.dart';

enum ClientMainPageTabsEnum {
  home,
  orders,
  offers,
  cart,
  more;

  String get filledIc {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return AppIcons.homeSmile2;
      case ClientMainPageTabsEnum.orders:
        return AppIcons.documentText1;
      case ClientMainPageTabsEnum.offers:
        return AppIcons.receiptDisscount1;
      case ClientMainPageTabsEnum.cart:
        return AppIcons.bag1;
      case ClientMainPageTabsEnum.more:
        return AppIcons.elementEqual;
    }
  }

  String get outlineIc {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return AppIcons.homeSmile;
      case ClientMainPageTabsEnum.orders:
        return AppIcons.documentText;
      case ClientMainPageTabsEnum.offers:
        return AppIcons.receiptDisscount;
      case ClientMainPageTabsEnum.cart:
        return AppIcons.bag2;
      case ClientMainPageTabsEnum.more:
        return AppIcons.elementEqual;
    }
  }

  String get title {
    switch (this) {
      case ClientMainPageTabsEnum.home:
        return appLocalizer.home;
      case ClientMainPageTabsEnum.orders:
        return appLocalizer.orders;
      case ClientMainPageTabsEnum.offers:
        return appLocalizer.offers;
      case ClientMainPageTabsEnum.cart:
        return appLocalizer.cart;
      case ClientMainPageTabsEnum.more:
        return appLocalizer.more;
    }
  }
}
