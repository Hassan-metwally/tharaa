part of core;

@Injectable()
class GetCachedUserUseCase {
  final SecureStorageRepository _repository;

  factory GetCachedUserUseCase.getInstance() => GetCachedUserUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  const GetCachedUserUseCase(this._repository);

  Future<CachedUser?> call() async {
    return await _repository.getCachedUser();
  }
}
