import 'package:injectable/injectable.dart';

import '../../core.dart';
import '../data_source/language_cache_date_source.dart';

@Injectable(as: LanguageCacheRepository)
class LanguageCacheRepositoryImp implements LanguageCacheRepository {
  final LanguageCacheDateSource _languageCacheDataSource;

  const LanguageCacheRepositoryImp(this._languageCacheDataSource);

  @override
  Future<void> clearCache() async {
    return await _languageCacheDataSource.clearCache();
  }

  @override
  AppLanguageEnum get getDefaultAppLanguage => _languageCacheDataSource.getDefaultAppLanguage;

  @override
  Future<AppLanguageEnum> getDeviceLanguage() async {
    return await _languageCacheDataSource.getDeviceLanguage();
  }

  @override
  Future<AppLanguageEnum> getLanguage() async {
    return await _languageCacheDataSource.getLanguage();
  }

  @override
  Future<bool> setLanguageCode(AppLanguageEnum language) async {
    return await _languageCacheDataSource.setLanguageCode(language);
  }
}
