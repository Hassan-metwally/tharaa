part of core;

@Injectable()
class DeleteTokenUseCase {
  final SecureStorageRepository _repository;

  factory DeleteTokenUseCase.getInstance() => DeleteTokenUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  const DeleteTokenUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteToken();
  }
}
