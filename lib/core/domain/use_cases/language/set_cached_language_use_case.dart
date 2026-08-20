part of core;

@Injectable()
class SetCachedLanguageUseCase {
  final LanguageCacheRepository _repository;

  const SetCachedLanguageUseCase(this._repository);

  factory SetCachedLanguageUseCase.getInstance() => SetCachedLanguageUseCase(LanguageCacheRepositoryImp(LanguageCacheDateSourceImp()));

  Future<bool> call(AppLanguageEnum language) async {
    return await _repository.setLanguageCode(language);
  }
}
