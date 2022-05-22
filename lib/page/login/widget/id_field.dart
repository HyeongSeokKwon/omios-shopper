import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_bloc/authentication_bloc.dart';

class IdTextField extends StatelessWidget {
  IdTextField({Key? key}) : super(key: key);
  final TextEditingController idTextController = TextEditingController();

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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  ],
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 4) {
                      return "아이디는 4글자 이상 입력해주세요";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (text) {
                    context
                        .read<AuthenticationBloc>()
                        .add(ChangeIdEvent(id: text));
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: idTextController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                      10 * Scale.width,
                      18 * Scale.height,
                      10 * Scale.width,
                      18 * Scale.height,
                    ),
                    counterText: "",
                    labelText: "아이디",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                      onPressed: () => idTextController.clear(),
                    ),
                    hintText: ("아이디를 입력하세요"),
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
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
