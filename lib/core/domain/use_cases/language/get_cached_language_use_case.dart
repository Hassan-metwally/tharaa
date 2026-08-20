part of core;

@Injectable()
class GetCachedLanguageUseCase {
  final LanguageCacheRepository _repository;

  const GetCachedLanguageUseCase(this._repository);

  factory GetCachedLanguageUseCase.getInstance() => GetCachedLanguageUseCase(LanguageCacheRepositoryImp(LanguageCacheDateSourceImp()));

  Future<AppLanguageEnum> call() async {
    return await _repository.getLanguage();
  }
}
