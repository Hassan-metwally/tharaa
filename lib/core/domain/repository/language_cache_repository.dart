part of core;

abstract class LanguageCacheRepository {
  Future<AppLanguageEnum> getLanguage();
  Future<bool> setLanguageCode(AppLanguageEnum language);
  Future<AppLanguageEnum> getDeviceLanguage();
  AppLanguageEnum get getDefaultAppLanguage;
  Future<void> clearCache();
}
