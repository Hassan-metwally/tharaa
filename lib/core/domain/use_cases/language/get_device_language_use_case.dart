part of core;

@Injectable()
class GetDeviceLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetDeviceLanguageUseCase(this._repository);

  factory GetDeviceLanguageUseCase.getInstance() => GetDeviceLanguageUseCase(LanguageCacheRepositoryImp(LanguageCacheDateSourceImp()));

  Future<AppLanguageEnum> call() async {
    return await _repository.getDeviceLanguage();
  }
}
