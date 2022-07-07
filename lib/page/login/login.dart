import 'dart:io';

import 'package:cloth_collection/bloc/auth_bloc/authentication_bloc.dart';
import 'package:cloth_collection/page/login/widget/login_widget.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import '../../repository/auth_repository.dart';
import '../../util/util.dart';

class Login extends StatefulWidget {
  final Widget routePage;
  const Login({Key? key, required this.routePage}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    getVibratePermission();
  }

  void getVibratePermission() async {
    try {
      await Vibrate.canVibrate;
    } on Exception catch (e) {
      showAlertDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Scale.setScale(context);
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authRepository: AuthRepository(), initAutoLogin: false),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listenWhen: ((previous, current) =>
              previous.authStatus != current.authStatus),
          listener: (context, state) {
            switch (state.authStatus) {
              case AuthStatus.loginSuccess:
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => widget.routePage,
                  ),
                );
                break;
              case AuthStatus.loginFailure:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(context.read<AuthenticationBloc>().state.error),
                  ),
                );
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
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 15.0),
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
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Container(
                    color: const Color(0xffffffff),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(),
                          Column(
                            children: [
                              SizedBox(height: 50 * Scale.height),
                              const LoginField(),
                              SizedBox(height: 16 * Scale.height),
                              const AutoLoginButton(),
                              SizedBox(height: 16 * Scale.height),
                              const LoginButton(),
                              SizedBox(height: 35 * Scale.height),
                              const FindPrivacy(),
                              SizedBox(height: 160 * Scale.height),
                              const SignUpButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
