part of core;

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

abstract base class AppRouter {
  const AppRouter._();

  static BuildContext get appContext => appNavigatorKey.currentContext!;

  static Future<T?> pushNamed<T extends Object?>(String name, {Object? arguments}) async {
    return await appNavigatorKey.currentState?.pushNamed<T?>(name, arguments: arguments);
  }

  static void popUntil<T>({bool? Function(Route<dynamic> route)? predicate, bool rootNavigator = true, BuildContext? context}) {
    Navigator.of(context ?? appContext, rootNavigator: rootNavigator).popUntil((route) {
      if (predicate != null) {
        return predicate(route)!;
      }
      return route.isFirst;
    });
  }

  static void pop<T>({bool rootNavigator = true, BuildContext? context, T? result}) {
    Navigator.of(context ?? appContext, rootNavigator: rootNavigator).pop(result);
  }

  static String? get getCurrentRoute {
    String? currentRoute;
    appNavigatorKey.currentState?.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });
    return currentRoute;
  }
}
