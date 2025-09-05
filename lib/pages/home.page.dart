// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:social_spot/helpers/colors.dart';
// import 'package:social_spot/helpers/constants.dart';
// import 'package:social_spot/helpers/routes/pages.dart';
// import 'package:social_spot/helpers/styles.dart';
// import 'package:social_spot/helpers/utils.dart';
// import 'package:social_spot/pages/ad/ad_view.page.dart';
// import 'package:social_spot/pages/home.header.dart';
// import 'package:social_spot/viewmodels/ad.viewmodel.dart';
// import 'package:social_spot/widgets/app_version.widget.dart';
// import 'package:social_spot/widgets/custom_button.widget.dart';
// import 'package:social_spot/widgets/menu_item.widget.dart';
// import 'package:open_settings_plus/open_settings_plus.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   var btnLoading = false;
//   CheckConnect isConnected = CheckConnect(isConnected: false);
//   bool isPermGranted = false; // IsPermissions Granted (Location Permission)

//   void checkConnected() async {
//     var permission = await Permission.location.isGranted;
//     var result = await utilsIsConnected();
//     setState(() {
//       isPermGranted = permission;
//       isConnected = result;
//     });
//   }

//   @override
//   void initState() {
//     checkConnected();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appPrimaryColor,
//         title: SvgPicture.asset(hubCityLogo, width: 80),
//         centerTitle: true,
//         leading: const SizedBox(),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: pagePadding),
//           child: Column(
//             children: [
//               const Gap(20),
//               const HomeHeader(),
//               const Gap(5),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
//               MenuItem(
//                 // color: warningColor,
//                 icon: requiredAutorization,
//                 title: "Autorisation nécéssaire",
//                 description: isPermGranted ? nothingHappen : requiredPerm,
//                 textColor: isPermGranted ? successColor : null,
//                 onPressed: () {
//                   checkLocationPermission().then(
//                     (value) => {if (value) checkConnected()},
//                   );
//                 },
//               ),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
//               MenuItem(
//                 // color: dangerColor,
//                 icon: wifiSymbol,
//                 title: "Connecté à",
//                 description: isConnected.isConnectedTo ?? "Non Connecté",
//                 textColor:
//                     isConnected.isConnected && isConnected.isConnectedTo != null
//                         ? successColor
//                         : dangerColor,
//                 extras: !isConnected.isConnected
//                     ? "Aucune connexion internet"
//                     : null,
//                 onPressed: () => const OpenSettingsPlusAndroid().wifi(),
//               ),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
//               MenuItem(
//                 // color: successColor,
//                 icon: pajamaRepeat,
//                 title: "Temps restant",
//                 description: "20 min",
//                 directChild: ElevatedButton(
//                   style: buttonStyleMini,
//                   child: RenewButton(isLoading: btnLoading),
//                   onPressed: () async {
//                     setState(() {
//                       btnLoading = true;
//                     });
//                     ref.read(getAdProvider.future).then((ad) {
//                       setState(() {
//                         btnLoading = false;
//                       });
//                       if (ad != null) {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => AdView(ad: ad),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                 ),
//                 onPressed: () {},
//               ),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
//               MenuItem(
//                 // color: Colors.blue,
//                 icon: settingIcon,
//                 title: "Paramètres",
//                 description: "Paramètres de l'application",
//                 onPressed: () => Navigator.pushNamed(context, AppPage.setting),
//               ),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const AppVersion(),
//     );
// }

import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/routes/pages.dart';
import 'package:social_spot/helpers/styles.dart';
import 'package:social_spot/helpers/utils.dart';
import 'package:social_spot/pages/ad/ad_view.page.dart';
import 'package:social_spot/pages/home.header.dart';
import 'package:social_spot/viewmodels/ad.viewmodel.dart';
import 'package:social_spot/widgets/app_version.widget.dart';
import 'package:social_spot/widgets/custom_button.widget.dart';
import 'package:social_spot/widgets/menu_item.widget.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:social_spot/services/internet_access.service.dart';

// Vérifier que la classe _HomePageState hérite bien de ConsumerState<HomePage>
// Toutes les méthodes utilisant setState doivent être dans la classe _HomePageState

// SUPPRESSION des variables et méthodes timer/session en dehors de la classe _HomePageState

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var btnLoading = false;
  CheckConnect isConnected = CheckConnect(isConnected: false);
  bool isPermGranted = false;
  int remainingSeconds = 0;
  DateTime? expiresAt;
  bool sessionActive = false;
  late final InternetAccessService _accessService;
  Timer? _timer;

  Future<void> fetchSessionStatus() async {
    try {
      final service = _accessService;
      final status = await service.getStatus();
      if (status["active"] == true && status["expiresAt"] != null) {
        expiresAt = DateTime.parse(status["expiresAt"]);
        final now = DateTime.now();
        remainingSeconds = expiresAt!.difference(now).inSeconds;
        sessionActive = remainingSeconds > 0;
        startTimer();
      } else {
        expiresAt = null;
        remainingSeconds = 0;
        sessionActive = false;
        stopTimer();
      }
      setState(() {});
    } catch (e) {
      print("Erreur fetchSessionStatus: $e");
      expiresAt = null;
      remainingSeconds = 0;
      sessionActive = false;
      stopTimer();
      setState(() {});
    }
  }

  void startTimer() {
    stopTimer();
    if (remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            sessionActive = false;
            timer.cancel();
          }
        });
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void checkConnected() async {
    try {
      // ✅ SOLUTION: Gestion conditionnelle selon la plateforme
      if (kIsWeb) {
        // Sur Web, simuler les permissions comme accordées
        var result = await utilsIsConnected();
        setState(() {
          isPermGranted = true; // Simulé comme accordé sur Web
          isConnected = result;
        });
        await fetchSessionStatus();
      } else {
        // Sur mobile, vérification normale
        var permission = await Permission.location.isGranted;
        var result = await utilsIsConnected();
        setState(() {
          isPermGranted = permission;
          isConnected = result;
        });
        await fetchSessionStatus();
      }
    } catch (e) {
      print("Erreur checkConnected: $e");
      setState(() {
        isPermGranted = kIsWeb; // true sur Web, false sur mobile
        isConnected = CheckConnect(isConnected: false);
        sessionActive = false;
        remainingSeconds = 0;
      });
    }
  }

  @override
  void initState() {
    _accessService = InternetAccessService();
    checkConnected();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: SvgPicture.asset(hubCityLogo, width: 80),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Center(
                child: Text(
                  "Accueil",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: likeBlueColor,
                  ),
                ),
              ),
              const Gap(20),
              const HomeHeader(),
              const Gap(5),
              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

              // ✅ Permission MenuItem - Adapté pour Web
              MenuItem(
                icon: requiredAutorization,
                title: "Autorisation nécessaire",
                description: isPermGranted
                    ? nothingHappen
                    : (kIsWeb ? "Permissions simulées sur Web" : requiredPerm),
                textColor: isPermGranted ? successColor : null,
                onPressed: () async {
                  if (kIsWeb) {
                    // Sur Web, juste mettre à jour l'état
                    setState(() {
                      isPermGranted = true;
                    });
                  } else {
                    // Sur mobile, demander vraiment la permission
                    try {
                      await checkLocationPermission();
                      checkConnected();
                    } catch (e) {
                      print("Erreur permission: $e");
                    }
                  }
                },
              ),

              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

              // ✅ WiFi MenuItem - Adapté pour Web
              MenuItem(
                icon: wifiSymbol,
                title: "Connecté à",
                description: isConnected.isConnectedTo ??
                    (kIsWeb ? "Connexion Web" : "Non Connecté"),
                textColor: isConnected.isConnected &&
                        (isConnected.isConnectedTo != null || kIsWeb)
                    ? successColor
                    : dangerColor,
                extras: !isConnected.isConnected
                    ? "Aucune connexion internet"
                    : null,
                onPressed: () {
                  if (kIsWeb) {
                    // Sur Web, afficher un message ou ouvrir les paramètres du navigateur
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Paramètres réseau disponibles dans votre navigateur"),
                      ),
                    );
                  } else {
                    // Sur mobile, ouvrir les paramètres WiFi
                    const OpenSettingsPlusAndroid().wifi();
                  }
                },
              ),

              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

              // Remplacement du MenuItem timer/ad par version backend
              MenuItem(
                icon: pajamaRepeat,
                title: "Temps restant",
                description: sessionActive
                    ? "${(remainingSeconds ~/ 60).toString().padLeft(2, '0')} min ${(remainingSeconds % 60).toString().padLeft(2, '0')} sec"
                    : "Accès expiré",
                directChild: ElevatedButton(
                  style: buttonStyleMini,
                  child: RenewButton(isLoading: btnLoading),
                  onPressed: sessionActive
                      ? null
                      : () async {
                          setState(() {
                            btnLoading = true;
                          });
                          try {
                            final ad = await ref.read(getAdProvider.future);
                            setState(() {
                              btnLoading = false;
                            });
                            if (ad != null) {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AdView(ad: ad),
                                ),
                              );
                              await _accessService.renewAccess(
                                  adId: int.tryParse(ad.id));
                              await fetchSessionStatus();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Aucune publicité disponible"),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          } catch (e) {
                            print("Erreur backend: $e");
                            setState(() {
                              btnLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Erreur de connexion: " + e.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                ),
                onPressed: () {},
              ),

              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

              // ✅ Settings MenuItem - Devrait fonctionner maintenant
              MenuItem(
                icon: settingIcon,
                title: "Paramètres",
                description: "Paramètres de l'application",
                onPressed: () {
                  try {
                    Navigator.pushNamed(context, AppPage.setting);
                  } catch (e) {
                    print("Erreur navigation settings: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Erreur navigation: ${e.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),

              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppVersion(),
    );
  }
}

// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:social_spot/helpers/colors.dart';
// import 'package:social_spot/helpers/constants.dart';
// import 'package:social_spot/helpers/routes/pages.dart';
// import 'package:social_spot/helpers/styles.dart';
// import 'package:social_spot/helpers/utils.dart';
// import 'package:social_spot/pages/ad/ad_view.page.dart';
// import 'package:social_spot/pages/home.header.dart';
// import 'package:social_spot/viewmodels/ad.viewmodel.dart';
// import 'package:social_spot/widgets/app_version.widget.dart';
// import 'package:social_spot/widgets/custom_button.widget.dart';
// import 'package:social_spot/widgets/menu_item.widget.dart';

// // ✅ IMPORTS AJOUTÉS :
// import 'package:social_spot/providers/wifi.provider.dart';
// import 'package:social_spot/pages/wifi_list.page.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   var btnLoading = false;
//   CheckConnect isConnected = CheckConnect(isConnected: false);
//   bool isPermGranted = false;

//   void checkConnected() async {
//     try {
//       if (kIsWeb) {
//         var result = await utilsIsConnected();
//         setState(() {
//           isPermGranted = true;
//           isConnected = result;
//         });
//       } else {
//         var permission = await Permission.location.isGranted;
//         var result = await utilsIsConnected();
//         setState(() {
//           isPermGranted = permission;
//           isConnected = result;
//         });
//       }
//     } catch (e) {
//       print("Erreur checkConnected: $e");
//       setState(() {
//         isPermGranted = kIsWeb;
//         isConnected = CheckConnect(isConnected: false);
//       });
//     }
//   }

//   @override
//   void initState() {
//     checkConnected();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appPrimaryColor,
//         title: SvgPicture.asset(hubCityLogo, width: 80),
//         centerTitle: true,
//         leading: const SizedBox(),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: pagePadding),
//           child: Column(
//             children: [
//               const Gap(20),
//               const HomeHeader(),
//               const Gap(5),
//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

//               MenuItem(
//                 icon: requiredAutorization,
//                 title: "Autorisation nécessaire",
//                 description: isPermGranted
//                     ? nothingHappen
//                     : (kIsWeb ? "Permissions simulées sur Web" : requiredPerm),
//                 textColor: isPermGranted ? successColor : null,
//                 onPressed: () async {
//                   if (kIsWeb) {
//                     setState(() {
//                       isPermGranted = true;
//                     });
//                   } else {
//                     try {
//                       await checkLocationPermission();
//                       checkConnected();
//                     } catch (e) {
//                       print("Erreur permission: $e");
//                     }
//                   }
//                 },
//               ),

//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

//               // ✅ MENU ITEM WiFi MODIFIÉ :
//               Consumer(
//                 builder: (context, ref, child) {
//                   final wifiState = ref.watch(wifiProvider);
                  
//                   return MenuItem(
//                     icon: wifiSymbol,
//                     title: "WiFi disponible",
//                     description: wifiState.connectedSSID ?? 
//                                 (isConnected.isConnectedTo ?? "Voir les réseaux"),
//                     textColor: (wifiState.connectedSSID != null || 
//                                (isConnected.isConnected && isConnected.isConnectedTo != null))
//                                ? successColor 
//                                : null,
//                     extras: !isConnected.isConnected ? "Aucune connexion internet" : null,
//                     onPressed: () {
//                       if (kIsWeb) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Fonctionnalité WiFi non disponible sur web"),
//                           ),
//                         );
//                       } else {
//                         // Ouvre la page de liste WiFi
//                         ref.read(wifiProvider.notifier).loadWifiNetworks();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const WifiListPage()),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),

//               Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),

//               MenuItem(
//                 icon: pajamaRepeat,
//                 title: "Temps restant",
//                 description: "20 min",
//                 directChild: ElevatedButton(
//                   style: buttonStyleMini,
//                   child: RenewButton(isLoading: btnLoading),
//                   onPressed: () async {
//                     setState(() {
//                       btnLoading = true;
//                     });

//                     try {
//                       final ad = await ref.read(getAdProvider.future);
//                       if (mounted) {
//                         setState(() {
//                           btnLoading = false;
//                         });
//                         if (ad != null) {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => AdView(ad: ad),
//                             ),