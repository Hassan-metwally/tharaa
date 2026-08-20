part of core;

@Injectable()
class SetTokenUseCase {
  final SecureStorageRepository _repository;

  SetTokenUseCase(this._repository);

  factory SetTokenUseCase.getInstance() => SetTokenUseCase(SecureStorageRepositoryImp(SecureStorageDataSourceImpl()));

  Future<void> call(Token params) async {
    return await _repository.setToken(params);
  }
}
