// class AppPage {
//   static const String welcome = '/'; // WelcomePage
//   static const String form = '/form'; // InappView
//   static const String main = '/main';
//   static const String signup = '/signup';
//   static const String home = '/home';
//   static const String setting = '/setting';
//   static const String config = '/config';
//   static const String adview = '/adview';
// }

// helpers/routes/app_page.dart
// class AppPages {
//   static const String welcome = '/';
//   static const String signup = '/signup';
// }
class AppPage {
  // Routes principales
  static const String home = '/';
  static const String main = '/main';
  static const String setting = '/setting';
  static const String config = '/config';
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';

  // Routes d'authentification
  static const String login = '/login';
  static const String welcome = '/'; // ✅ Route principale
  static const String signup = '/signup';
  static const String adview = '/adview'; // ✅ Ajout du '/' manquant
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';

  // Routes principales de l'app
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Routes des publicités
  static const String ads = '/ads';
  static const String adDetails = '/ad-details';

  // Routes WiFi
  static const String wifiConnection = '/wifi-connection';
  static const String networkSettings = '/network-settings';
}
