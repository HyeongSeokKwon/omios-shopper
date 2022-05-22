part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class ChangeIdEvent extends AuthenticationEvent {
  final String id;
  const ChangeIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class ChangePasswordEvent extends AuthenticationEvent {
  final String password;
  const ChangePasswordEvent({required this.password});
  @override
  List<Object> get props => [password];
}

class ClickLoginButtonEvent extends AuthenticationEvent {
  final String id;
  final String password;

  const ClickLoginButtonEvent({
    required this.id,
    required this.password,
  });
}

class ClickAutoLoginButtonEvent extends AuthenticationEvent {}

class AutoLoginEvent extends AuthenticationEvent {}
