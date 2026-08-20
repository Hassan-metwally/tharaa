import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';
import '../data_source/secure_storage_data_source.dart';

@Injectable(as: SecureStorageRepository)
class SecureStorageRepositoryImp implements SecureStorageRepository {
  final SecureStorageDataSource _dataSource;

  const SecureStorageRepositoryImp(this._dataSource);

  @override
  Future<Token?> getToken() async {
    try {
      return await _dataSource.getToken();
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to get token");
      return null;
    }
  }

  @override
  Future<void> setToken(Token token) async {
    try {
      await _dataSource.setToken(TokenModel.fromEntity(token));
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to delete token");
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _dataSource.deleteToken();
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to delete token");
    }
  }

  @override
  Future<void> setCachedUser(CachedUser user) async {
    try {
      return await _dataSource.setCachedUser(CacheUserModel.fromEntity(user));
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to set cached user");
    }
  }

  @override
  Future<CachedUser?> getCachedUser() async {
    try {
      final userData = await _dataSource.getCachedUser();
      debugPrint("[SecureStorageRepository] $userData");
      return userData;
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to get cached user");
      return null;
    }
  }

  @override
  Future<void> deleteCachedUser() async {
    try {
      await _dataSource.deleteCachedUser();
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to delete cached user");
    }
  }

  @override
  Future<void> deleteAllCache() async {
    try {
      await deleteToken();
      await deleteCachedUser();
    } catch (_) {
      debugPrint("[SecureStorageRepository] Failed to delete all cache");
    }
  }
}
