part of core;

@Injectable()
class GetIsUserAuthenticatedUseCase {
  GetIsUserAuthenticatedUseCase();
  final GetTokenUseCase _getTokenUseCase = GetTokenUseCase.getInstance();
  final GetCachedUserUseCase _getCachedUserUseCase = GetCachedUserUseCase.getInstance();

  Future<({bool isAuthenticated, CachedUser? cachedUser})> call() async {
    try {
      final token = await _getTokenUseCase();
      final cachedUser = await _getCachedUserUseCase();
      final bool isAuthenticated = (token != null && token.isValid) && cachedUser != null;
      return (isAuthenticated: isAuthenticated, cachedUser: cachedUser);
    } catch (_) {
      debugPrint("[GetIsUserAuthenticatedUseCase] Failed to get is user authenticated");
      return (isAuthenticated: false, cachedUser: null);
    }
  }
}
