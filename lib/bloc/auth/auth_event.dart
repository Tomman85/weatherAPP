part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final fbAuth.User? user;

  AuthStateChangedEvent({this.user});
}

class SignOutRequestEvent extends AuthEvent{

}