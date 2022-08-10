part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState {
  final AuthStatus authStatus;
  final fb_auth.User? user;

  AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unknown() {
    return AuthState(
      authStatus: AuthStatus.unknown,
    );
  }

  AuthState copyWith({
    AuthStatus? authStatus,
    fb_auth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
