part of core;

/// Events are:
/// 1- AppStarted
/// 2- Authenticated
/// 3- LoggedOut
/// 4- WalkthroughDone
/// 5- AuthRestart

abstract class AppAuthenticationEvent extends Equatable {
  const AppAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AppAuthenticationEvent {
  const AppStartedEvent();
}

class OnFinishWalkThrowEvent extends AppAuthenticationEvent {
  const OnFinishWalkThrowEvent();
}

class AuthenticatedEvent extends AppAuthenticationEvent {
  const AuthenticatedEvent();
}

class GuestEvent extends AppAuthenticationEvent {
  const GuestEvent();
}

class LoggedOutEvent extends AppAuthenticationEvent {
  const LoggedOutEvent();
}

class AuthRestartEvent extends AppAuthenticationEvent {
  const AuthRestartEvent();
}
