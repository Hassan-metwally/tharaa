part of core;

@Injectable()
class DeleteAllSecureCacheUseCase {
  final SecureStorageRepository _repository;

  const DeleteAllSecureCacheUseCase(this._repository);

  factory DeleteAllSecureCacheUseCase.getInstance() =>
      DeleteAllSecureCacheUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  Future<void> call() async {
    return await _repository.deleteAllCache();
  }
}
