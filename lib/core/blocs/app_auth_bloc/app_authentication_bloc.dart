part of core;

class AppAuthenticationBloc extends Bloc<AppAuthenticationEvent, AppAuthenticationState> {
  static AppAuthenticationBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  AppAuthenticationBloc() : super(AuthUninitialized()) {
    on<AppStartedEvent>(_onAppStarted);
    on<AuthenticatedEvent>(_onAuthenticated);
    on<OnFinishWalkThrowEvent>(_onFinishWalkThrow);
    on<GuestEvent>(_onContinueAsGuest);
    on<AuthRestartEvent>(_onAuthRestart);
    on<LoggedOutEvent>(_onLogout);
  }

  final _getIsUserAuthenticatedUseCase = GetIsUserAuthenticatedUseCase();
  final _deleteAllCachedUseCase = DeleteAllSecureCacheUseCase.getInstance();
  final _getCachedUserUseCase = GetCachedUserUseCase.getInstance();

  void _onAppStarted(AppStartedEvent event, Emitter<AppAuthenticationState> emit) async {
    _log("Auth Started");
    await _startMainApp(emit);
  }

  Future<void> _startMainApp(Emitter<AppAuthenticationState> emit) async {
    final getIsAuthResult = await _getIsUserAuthenticatedUseCase();
    final bool isAuthenticated = getIsAuthResult.isAuthenticated;
    final cachedUser = getIsAuthResult.cachedUser;
    if (isAuthenticated && cachedUser != null) {
      emit(AuthAuthenticatedState(user: cachedUser));
    } else {
      _log("Auth Un Authenticated");
      await _deleteAllCachedUseCase();
      emit(AuthUnauthenticated());
    }
  }

  void _onFinishWalkThrow(OnFinishWalkThrowEvent event, Emitter<AppAuthenticationState> emit) async {
    _log("Auth Log In Page");
    emit(AuthLogInPageState());
  }

  void _onAuthenticated(AuthenticatedEvent event, Emitter<AppAuthenticationState> emit) async {
    final cachedUser = await _getCachedUserUseCase();
    if (cachedUser != null) {
      _log("Auth Authenticated State");
      emit(AuthAuthenticatedState(user: cachedUser));
    } else {
      _startMainApp(emit);
    }
  }

  void _onAuthRestart(AuthRestartEvent event, Emitter<AppAuthenticationState> emit) async {
    _log("Auth Restarted");
    emit(AuthUninitialized());
    await _startMainApp(emit);
  }

  void _onLogout(LoggedOutEvent event, Emitter<AppAuthenticationState> emit) async {
    await _deleteAllCachedUseCase();
    FirebaseHelper.deleteDeviceFcmToken();
    _log('Auth Log Out');
    emit(AuthLogOutState());
  }

  void _onContinueAsGuest(GuestEvent event, Emitter<AppAuthenticationState> emit) async {
    _log("Auth GuestState");
    emit(AuthUninitialized());
    await Future.delayed(Durations.medium1);
    emit(GuestState());
  }

  void _log(String message) {
    debugPrint('[AppAuthenticationBloc] ::: $message :::');
  }

  @override
  void onEvent(AppAuthenticationEvent event) {
    if (!isClosed) {
      super.onEvent(event);
    }
  }
}
