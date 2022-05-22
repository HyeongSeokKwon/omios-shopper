part of 'authentication_bloc.dart';

enum AuthStatus {
  deviceInit,
  authenticated,
  unauthenticated,
  loginSuccess,
  loginFailure,
  loginError,
  loading
}

class AuthenticationState extends Equatable {
  final String id;
  final String password;
  final bool autoLogin;
  final AuthStatus authStatus;
  final String error;

  const AuthenticationState({
    required this.id,
    required this.password,
    required this.autoLogin,
    required this.authStatus,
    required this.error,
  });

  factory AuthenticationState.initial(bool autoLogin) {
    return AuthenticationState(
      id: '',
      password: '',
      autoLogin: autoLogin,
      authStatus: AuthStatus.deviceInit,
      error: '',
    );
  }

  @override
  List<Object> get props => [id, password, autoLogin, authStatus, error];

  AuthenticationState copyWith({
    String? id,
    String? password,
    bool? autoLogin,
    AuthStatus? authStatus,
    String? error,
  }) {
    return AuthenticationState(
      id: id ?? this.id,
      password: password ?? this.password,
      autoLogin: autoLogin ?? this.autoLogin,
      authStatus: authStatus ?? this.authStatus,
      error: error ?? this.error,
    );
  }
}
