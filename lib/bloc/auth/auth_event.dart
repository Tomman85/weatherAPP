part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;

  AuthStateChangedEvent({this.user});
}

class SignOutRequestEvent extends AuthEvent {}

class DeletionRequestedEvent extends AuthEvent{}
