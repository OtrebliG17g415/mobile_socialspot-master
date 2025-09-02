import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/theme.dart';
import 'package:social_spot/pages/welcome.page.dart';
import 'package:social_spot/pages/ad/inapp_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social Spot",
      navigatorKey: navigatorKey,
      theme: appLightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/form': (context) => const InappView(
              url: "https://docs.google.com/forms/d/e/XXXXXXXXXXXXXXX/viewform",
            ),
      },
    );
  }
}
