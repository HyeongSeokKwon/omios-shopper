import 'package:cloth_collection/page/login/widget/password_field.dart';
import 'package:flutter/material.dart';

import '../../../util/util.dart';
import 'id_field.dart';

class LoginField extends StatelessWidget {
  const LoginField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          IdTextField(),
          SizedBox(height: 16 * Scale.height),
          PasswordTextField(),
        ],
      ),
    );
  }
}
