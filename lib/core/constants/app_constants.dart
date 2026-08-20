part of core;

class AppConstants {
  const AppConstants._();

  static const String appleProviderUrl = "https:azahmni.moltaqadev.com/temp";
  static const String googlePlayUrl = "https:azahmni.moltaqadev.com/temp";

  static String get getAppProductionUrl {
    if (Platform.isAndroid) {
      return googlePlayUrl;
    } else {
      return appleProviderUrl;
    }
  }
}
