import 'package:flutter/material.dart';
import 'package:social_spot/helpers/styles.dart';
import 'package:social_spot/widgets/renew_loading.widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.title = "Continuer",
  });

  final String? title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      child: Text(
        title!,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () => onPressed(),
    );
  }
}

class RenewButton extends StatelessWidget {
  const RenewButton({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: isLoading
          ? const RenewLoading()
          : const Text(
              "Renouveler",
              style: TextStyle(color: Colors.white),
            ),
    );
  }
}
