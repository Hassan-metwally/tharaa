part of core;

abstract class AppAuthenticationState extends Equatable {
  const AppAuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthAuthenticatedState extends AppAuthenticationState {
  final CachedUser user;

  const AuthAuthenticatedState({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUninitialized extends AppAuthenticationState {}

class AuthLogInPageState extends AppAuthenticationState {}

class AuthLogOutState extends AppAuthenticationState {}

class GuestState extends AppAuthenticationState {}

class AuthUnauthenticated extends AppAuthenticationState {}
