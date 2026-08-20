import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';

const String _tokenKey = "CacheTokenKey";
const String _cacheUserDataKey = "CacheUserDataKey";

abstract class SecureStorageDataSource {
  Future<void> setToken(TokenModel token);
  Future<TokenModel?> getToken();
  Future<void> deleteToken();
  Future<void> setCachedUser(CacheUserModel user);
  Future<CacheUserModel?> getCachedUser();
  Future<void> deleteCachedUser();
}

@Injectable(as: SecureStorageDataSource)
class SecureStorageDataSourceImpl implements SecureStorageDataSource {
  final FlutterSecureStorage _storageObj = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  @override
  Future<void> setToken(TokenModel token) async {
    try {
      await _storageObj.write(key: _tokenKey, value: token.toJson);
      if (ApiConstants.canLog) {
        debugPrint("[SecureStorageDataSource] ::: Token Saved Successfully \n[${token.toString()}]");
      }
    } catch (_) {
      throw SecureStorageException(message: "Failed to save token to cache ، please try again");
    }
  }

  @override
  Future<TokenModel?> getToken() async {
    try {
      final json = await _storageObj.read(key: _tokenKey);
      if (json != null) {
        final token = TokenModel.fromCache(json);
        if (ApiConstants.canLog) {
          debugPrint("[SecureStorageDataSource] ::: Get Token Successfully \n[${token.toString()}]");
        }
        return token;
      }
      return null;
    } catch (_) {
      throw SecureStorageException(message: "Failed to get token from cache ، please try again");
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _storageObj.delete(key: _tokenKey);
      debugPrint("[SecureStorageDataSource] ::: Token Deleted Successfully");
    } catch (_) {
      throw SecureStorageException(message: "Failed to delete token from cache ، please try again");
    }
  }

  @override
  Future<void> setCachedUser(CacheUserModel user) async {
    try {
      await _storageObj.write(key: _cacheUserDataKey, value: user.toJson);
      if (ApiConstants.canLog) {
        debugPrint("[SecureStorageDataSource] ::: Cache User Saved Successfully\n${user.toString()}");
      }
    } catch (_) {
      throw SecureStorageException(message: "Failed to save cached user to cache ، please try again");
    }
  }

  @override
  Future<CacheUserModel?> getCachedUser() async {
    try {
      final json = await _storageObj.read(key: _cacheUserDataKey);
      if (json != null) {
        final cachedData = CacheUserModel.fromJson(json);
        return cachedData;
      }
      return null;
    } catch (_) {
      throw SecureStorageException(message: "Failed to get cached user from cache ، please try again");
    }
  }

  @override
  Future<void> deleteCachedUser() async {
    try {
      await _storageObj.delete(key: _cacheUserDataKey);
      if (ApiConstants.canLog) {
        debugPrint("[SecureStorageDataSource] ::: Cached User Deleted Successfully");
      }
    } catch (_) {
      throw SecureStorageException(message: "Failed to delete cached user from cache ، please try again");
    }
  }
}
