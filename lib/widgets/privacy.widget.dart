import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "En continuant, vous acceptez nos",
          style: GoogleFonts.nunito().copyWith(fontSize: 13),
        ),
        Text(
          "Condition d'utilisation & Politique de confidentialité",
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
