import 'package:cloth_collection/bloc/auth_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/util.dart';

class AutoLoginButton extends StatelessWidget {
  const AutoLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        print(context.read<AuthenticationBloc>().state.autoLogin);
        return Padding(
          padding: EdgeInsets.only(left: 22 * Scale.width),
          child: InkWell(
            child: SizedBox(
              height: 20 * Scale.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20 * Scale.width,
                    height: 20 * Scale.width,
                    child: context.read<AuthenticationBloc>().state.autoLogin
                        ? SvgPicture.asset("assets/images/svg/login.svg")
                        : SvgPicture.asset("assets/images/svg/unlogin.svg"),
                  ),
                  SizedBox(
                    width: 10 * Scale.width,
                  ),
                  Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(ClickAutoLoginButtonEvent());
            },
          ),
        );
      },
    );
  }
}
