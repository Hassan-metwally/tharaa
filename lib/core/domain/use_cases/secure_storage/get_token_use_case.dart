part of core;

@Injectable()
class GetTokenUseCase {
  final SecureStorageRepository _repository;

  GetTokenUseCase(this._repository);

  factory GetTokenUseCase.getInstance() => GetTokenUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  Future<Token?> call() async {
    return await _repository.getToken();
  }
}
