import 'package:flutter/material.dart';
import 'package:social_spot/helpers/colors.dart';

var buttonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith(
    (color) => appPrimaryColor,
  ),
  padding: WidgetStateProperty.resolveWith(
    (padding) => const EdgeInsets.symmetric(vertical: 10),
  ),
);

var buttonStyleMini = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith(
    (color) => appPrimaryColor,
  ),
  padding: WidgetStateProperty.resolveWith(
    (padding) => const EdgeInsets.symmetric(vertical: 5),
  ),
  shape: WidgetStateProperty.resolveWith(
    (shape) => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
