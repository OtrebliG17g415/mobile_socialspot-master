import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_spot/helpers/colors.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Social Spot",
            style: GoogleFonts.adventPro().copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: likeBlueColor,
            ),
          ),
          const Text(
            "V 1.0.1",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
