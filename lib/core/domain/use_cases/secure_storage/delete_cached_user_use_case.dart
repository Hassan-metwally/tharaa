part of core;

@Injectable()
class DeleteCachedUserUseCase {
  final SecureStorageRepository _repository;

  const DeleteCachedUserUseCase(this._repository);

  factory DeleteCachedUserUseCase.getInstance() => DeleteCachedUserUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  Future<void> call() async {
    return await _repository.deleteCachedUser();
  }
}
