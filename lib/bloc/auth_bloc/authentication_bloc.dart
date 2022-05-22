import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  late SharedPreferences prefs;
  bool initAutoLogin;

  AuthenticationBloc(
      {required this.authRepository, required this.initAutoLogin})
      : super(AuthenticationState.initial(initAutoLogin)) {
    on<ChangeIdEvent>(changeId);
    on<ChangePasswordEvent>(changePassword);
    on<ClickLoginButtonEvent>(clickLoginButton);
    on<ClickAutoLoginButtonEvent>(clickAutoLoginButton);
    on<AutoLoginEvent>(checkedAutoLogin);
  }

  void changeId(ChangeIdEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(id: event.id, authStatus: AuthStatus.unauthenticated));
  }

  void changePassword(
      ChangePasswordEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
        password: event.password, authStatus: AuthStatus.unauthenticated));
  }

  void clickAutoLoginButton(ClickAutoLoginButtonEvent event,
      Emitter<AuthenticationState> emit) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('autoLogin', !state.autoLogin);
    emit(state.copyWith(autoLogin: !state.autoLogin));
  }

  Future<void> clickLoginButton(
      ClickLoginButtonEvent event, Emitter<AuthenticationState> emit) async {
    if (event.id.isEmpty || event.password.isEmpty) {
      return;
    }

    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      Map response = await authRepository.basicLogin(event.id, event.password);

      switch (response['code']) {
        case 201:
          if (Jwt.parseJwt(response['data']['access'])['user_type'] ==
              'wholesaler') {
            emit(state.copyWith(
                authStatus: AuthStatus.loginFailure,
                error: "아이디 패스워드가 존재하지 않습니다."));
            return;
          }
          authRepository.setAccessToken(response['data']['access']);
          authRepository.setRefreshToken(response['data']['refresh']);

          emit(state.copyWith(authStatus: AuthStatus.loginSuccess));
          break;

        case 401:
          emit(state.copyWith(
              authStatus: AuthStatus.loginFailure,
              error: "아이디 패스워드가 존재하지 않습니다."));
          return;
      }
    } catch (e) {
      emit(state.copyWith(
          authStatus: AuthStatus.loginError, error: e.toString()));
    }
  }

  Future<void> checkedAutoLogin(
      AutoLoginEvent event, Emitter<AuthenticationState> emit) async {
    prefs = await SharedPreferences.getInstance();

    bool? isAutoLoginClicked = prefs.getBool('autoLogin');
    String? refreshToken = prefs.getString('refreshToken');
    Map response;
    if (isAutoLoginClicked == true && refreshToken != null) {
      try {
        response = await authRepository.autoLogin(refreshToken);
        switch (response['code']) {
          case 201:
            authRepository.setAccessToken(response['data']['access']);
            authRepository.setRefreshToken(response['data']['refresh']);
            authRepository.id =
                Jwt.parseJwt(response['data']['access'])['user_id'];

            emit(state.copyWith(
                authStatus: AuthStatus.authenticated,
                autoLogin: isAutoLoginClicked ?? false));
            break;
          case 401:
            emit(state.copyWith(
                authStatus: AuthStatus.unauthenticated,
                autoLogin: isAutoLoginClicked ?? false));
            break;

          default:
            emit(state.copyWith(
                authStatus: AuthStatus.loginFailure,
                autoLogin: isAutoLoginClicked ?? false));
        }
      } catch (e) {
        emit(state.copyWith(
            authStatus: AuthStatus.loginError, error: e.toString()));
      }
    } else {
      emit(state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          autoLogin: isAutoLoginClicked ?? false));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
