import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_spot/app.dart';
import 'package:social_spot/helpers/routes/pages.dart';
import 'package:social_spot/pages/home.page.dart';
import 'package:social_spot/pages/setting.page.dart';
import 'package:social_spot/pages/setting_config.page.dart';
import 'package:social_spot/pages/signup.page.dart';
import 'package:social_spot/pages/welcome.page.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppPage.main:
        return MaterialPageRoute(
          builder: (context) => const SocialSpotApp(),
        );
      case AppPage.welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case AppPage.signup:
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        );
      case AppPage.home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case AppPage.setting:
        return MaterialPageRoute(
          builder: (context) => const SettingPage(),
        );
      case AppPage.config:
        return MaterialPageRoute(
          builder: (context) => const SettingConfigPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                "UnKnown",
                style: GoogleFonts.poppins().copyWith(fontSize: 16),
              ),
            ),
          ),
        );
    }
  }
}
