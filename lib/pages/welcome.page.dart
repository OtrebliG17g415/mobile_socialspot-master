import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/routes/pages.dart';
import 'package:social_spot/helpers/utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SvgPicture.asset(hubCityLogo, width: 120),
                const Image(
                  image: AssetImage(socialSpotLogo),
                  width: 200,
                ),
                Text(
                  "Social Spot",
                  style: GoogleFonts.adventPro().copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Earn free connection with Ads",
                  style: GoogleFonts.adventPro().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(50),
                SvgPicture.asset(
                  connectionBro,
                  width: 140,
                ),
                const Gap(50),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (color) => appSecondaryColor,
                    ),
                    shape: WidgetStateProperty.resolveWith(
                      (color) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    var result = checkLocationPermission();
                    result.then(
                      (value) {
                        if (value) Navigator.pushNamed(context, AppPage.signup);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
