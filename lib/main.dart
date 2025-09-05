import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/welcome.page.dart';
import 'pages/signup.page.dart';
import 'pages/auth/otp.dart';
import 'pages/auth/login_page.dart';
import 'pages/home.page.dart';
import 'pages/setting.page.dart';
import 'pages/setting_config.page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Spot',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/signup': (context) => const SignupPage(),
        '/otp': (context) => const OtpPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/setting': (context) => const SettingPage(),
        '/setting_config': (context) => const SettingConfigPage(),
        // Les pages AdView, VideoAdPage, StoreAdPage, FormAdPage doivent être ouvertes via Navigator avec arguments
      },
    );
  }
}
