import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/auth_bloc/authentication_bloc.dart';
import '../repository/auth_repository.dart';
import '../util/util.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late bool autoLogin;

  Future<bool> getAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    autoLogin = prefs.getBool("autoLogin") ?? false;
    print(autoLogin);
    if (!autoLogin) {
      Navigator.popAndPushNamed(context, '/login');
    }
    return autoLogin;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2), (() {
        return getAutoLogin();
      })),
      builder: (context, snapshot) {
        Scale.setScale(context);
        if (snapshot.hasData) {
          return BlocProvider(
            create: (context) => AuthenticationBloc(
                authRepository: AuthRepository(), initAutoLogin: autoLogin),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.authStatus) {
                  case AuthStatus.authenticated:
                    Navigator.popAndPushNamed(context, '/home');

                    break;
                  case AuthStatus.unauthenticated:
                    Navigator.popAndPushNamed(context, '/login');
                    break;
                  case AuthStatus.loginError:
                    if (Platform.isIOS) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content: Text(state.error),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: const Text("확인"),
                                  onPressed: () {
                                    setState(() {});
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              state.error,
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 16.0),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "확인",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, 'NotoSansKR', 15.0),
                                ),
                                onPressed: () {
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    break;
                  default:
                    break;
                }
              },
              builder: (context, state) {
                context.read<AuthenticationBloc>().add(AutoLoginEvent());
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        "Splash Screen",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  "Splash Screen",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
