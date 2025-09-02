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

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var btnLoading = false;
  CheckConnect isConnected = CheckConnect(isConnected: false);
  bool isPermGranted = false; // IsPermissions Granted (Location Permission)

  void checkConnected() async {
    var permission = await Permission.location.isGranted;
    var result = await utilsIsConnected();
    setState(() {
      isPermGranted = permission;
      isConnected = result;
    });
  }

  @override
  void initState() {
    checkConnected();
    super.initState();
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
            children: [
              const Gap(20),
              const HomeHeader(),
              const Gap(5),
              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
              MenuItem(
                // color: warningColor,
                icon: requiredAutorization,
                title: "Autorisation nécéssaire",
                description: isPermGranted ? nothingHappen : requiredPerm,
                textColor: isPermGranted ? successColor : null,
                onPressed: () {
                  checkLocationPermission().then(
                    (value) => {if (value) checkConnected()},
                  );
                },
              ),
              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
              MenuItem(
                // color: dangerColor,
                icon: wifiSymbol,
                title: "Connecté à",
                description: isConnected.isConnectedTo ?? "Non Connecté",
                textColor:
                    isConnected.isConnected && isConnected.isConnectedTo != null
                        ? successColor
                        : dangerColor,
                extras: !isConnected.isConnected
                    ? "Aucune connexion internet"
                    : null,
                onPressed: () => const OpenSettingsPlusAndroid().wifi(),
              ),
              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
              MenuItem(
                // color: successColor,
                icon: pajamaRepeat,
                title: "Temps restant",
                description: "20 min",
                directChild: ElevatedButton(
                  style: buttonStyleMini,
                  child: RenewButton(isLoading: btnLoading),
                  onPressed: () async {
                    setState(() {
                      btnLoading = true;
                    });
                    ref.read(getAdProvider.future).then((ad) {
                      setState(() {
                        btnLoading = false;
                      });
                      if (ad != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AdView(ad: ad),
                          ),
                        );
                      }
                    });
                  },
                ),
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 35, color: Colors.grey.shade300),
              MenuItem(
                // color: Colors.blue,
                icon: settingIcon,
                title: "Paramètres",
                description: "Paramètres de l'application",
                onPressed: () => Navigator.pushNamed(context, AppPage.setting),
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
