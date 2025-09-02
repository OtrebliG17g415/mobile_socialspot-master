import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_spot/helpers/colors.dart';

class AppFunction extends StatelessWidget {
  const AppFunction({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
  });

  final String icon;
  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (color) => appPrimaryColor.withOpacity(0.5),
          ),
          padding: WidgetStateProperty.resolveWith(
            (color) => const EdgeInsets.all(12),
          ),
        ),
        icon: SvgPicture.asset(icon),
        onPressed: () => onPressed(),
      ),
    );
  }
}
