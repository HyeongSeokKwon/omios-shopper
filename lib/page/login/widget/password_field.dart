import 'package:cloth_collection/bloc/auth_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/util.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField({Key? key}) : super(key: key);

  final TextEditingController pwdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
          child: Stack(
            children: [
              SizedBox(
                child: TextFormField(
                  showCursor: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  ],
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 6) {
                      return "비밀번호는 6글자 이상 입력해주세요";
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    context
                        .read<AuthenticationBloc>()
                        .add(ChangePasswordEvent(password: value));
                  }),
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: pwdTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                      10 * Scale.width,
                      18 * Scale.height,
                      10 * Scale.width,
                      18 * Scale.height,
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14 * Scale.height,
                    ),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.clear,
                        color: const Color(0xff666666),
                        size: 20.0 * Scale.width,
                      ),
                      onPressed: () => pwdTextController.clear(),
                    ),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
