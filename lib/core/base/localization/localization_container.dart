part of core;

AppLocalizations get appLocalizer => injector<LocalizationContainer>().appLocalizations;

Locale get getLocale {
  try {
    final context = appNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      return Localizations.localeOf(context);
    }
    return injector<LocalizationContainer>().getLang.local;
  } catch (_) {
    return const Locale("en");
  }
}

AppLanguageEnum get getLocaleTypeEnum {
  try {
    return AppLanguageEnum.fromLanguageCode(getLocale.languageCode);
  } catch (_) {
    return AppLanguageEnum.ar;
  }
}

/// This class will be registered manually in initializeDependencies()
/// Initial [AppLanguageEnum] value is set in [LanguagePreferencesHelper]
// @LazySingleton()
class LocalizationContainer {
  final _getLanguageUseCase = GetCachedLanguageUseCase.getInstance();
  final _setLanguageUseCase = SetCachedLanguageUseCase.getInstance();

  LocalizationContainer();

  AppLanguageEnum _lang = AppLanguageEnum.ar;

  AppLanguageEnum get getLang => _lang;

  AppLocalizations appLocalizations = AppLocalizationsAr();

  // @PostConstruct(preResolve: true)
  Future<Locale> init() async {
    Locale locale;
    _lang = await _getLanguageUseCase();
    locale = _lang.local;
    return locale;
  }

  Future<void> setLanguage(AppLanguageEnum lang) async {
    _lang = lang;
    await _setLanguageUseCase(lang);
  }

  /// Used For easy access [appLocalizer] without need [context]
  void setLocalizer(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
  }
}
