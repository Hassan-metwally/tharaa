part of core;

@Injectable()
class SetCachedUserUseCase {
  final SecureStorageRepository _repository;

  SetCachedUserUseCase(this._repository);

  factory SetCachedUserUseCase.getInstance() => SetCachedUserUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  Future<void> call(CachedUser params) async {
    return await _repository.setCachedUser(params);
  }
}
