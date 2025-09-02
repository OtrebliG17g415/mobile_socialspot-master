import 'package:flutter/material.dart';

class RenewLoading extends StatelessWidget {
  const RenewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 1,
      ),
    );
  }
}
