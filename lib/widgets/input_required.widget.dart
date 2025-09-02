import 'package:flutter/material.dart';
import 'package:social_spot/helpers/colors.dart';

class InputRequired extends StatelessWidget {
  const InputRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "*",
      style: TextStyle(color: dangerColor),
    );
  }
}
