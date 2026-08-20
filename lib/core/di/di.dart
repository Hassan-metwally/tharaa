// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core.dart';
import 'di.config.dart';

final injector = GetIt.instance;

const kInjectableProviderEnvironment = Environment('provider');
const kInjectableUserEnvironment = Environment('user');

@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
Future<void> initializeDependencies() async {
  injector.registerLazySingleton(() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  final sharedPrefInstance = await SharedPreferences.getInstance();
  injector.registerLazySingleton<SharedPreferences>(() => sharedPrefInstance);
  injector.registerSingleton(LocalizationContainer());
  await injector<LocalizationContainer>().init();

  // Push new scope, so when i reset the scope,
  // the LocalizationContainer does not get reset with it
  injector.pushNewScope(
    init: (_) async {
      await configureDependencies();
    },
  );
}

Future<void> configureDependencies() async {
  injector.init();
}

Future<void> resetDependenciesScope() async {
  await injector.resetScope();
  await configureDependencies();
}

@module
abstract class RegisterModule {
  @injectable
  CancelToken get dioCancelToken => CancelToken();

  @injectable
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConstants.apiBaseUrl,
      receiveDataWhenStatusError: true,
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
    ),
  );
}
