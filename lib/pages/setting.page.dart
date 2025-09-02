import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/routes/pages.dart';
import 'package:social_spot/widgets/app_version.widget.dart';
import 'package:social_spot/widgets/menu_item.widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Paramètres",
          style: TextStyle(color: likeBlueColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            children: [
              const Gap(30),
              MenuItem(
                color: Colors.blueGrey,
                icon: settingIcon,
                title: "Paramètres",
                description: "Configurer l'application",
                onPressed: () => Navigator.pushNamed(context, AppPage.config),
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
              MenuItem(
                color: Colors.blueGrey,
                icon: moonLight,
                title: "Thème",
                description: "Changer le thème de l'application",
                directChild: Switch(
                  onChanged: (value) {},
                  value: true,
                ),
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
              MenuItem(
                color: Colors.blueGrey,
                icon: privacyPolicy,
                title: "Politique de confidentialité",
                description: "Politique d'utilisation des données",
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
              MenuItem(
                color: Colors.blueGrey,
                icon: tablerSend,
                title: "Partager l'application",
                description: "Partager Social Spot avec vos amis",
                onPressed: () async => await Share.share(
                  'check out my website https://example.com',
                ),
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppVersion(),
    );
  }
}
