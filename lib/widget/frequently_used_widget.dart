import 'package:flutter/material.dart';

Widget progressBar() => Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.transparent,
        ),
      ),
    );
