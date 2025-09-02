import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/widgets/menu_item.widget.dart';

class SettingConfigPage extends StatelessWidget {
  const SettingConfigPage({super.key});

  /* 
    Pour les configs: 
    Sauvegarder d'abord les configs avec des noms en local.
    Les utiliser quand on en a besoin.

    Par exemple Recevoir les notifications peut être enregistré
    (receive_notifications)
    Lorsque la notification arrive vérifier si le paramètre est true
    et afficher ou non la notification.
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Configuration",
          style: TextStyle(color: likeBlueColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            children: [
              const Gap(30),
              ConfigItem(
                title: "Renouveler automatiquement",
                description: "Les publicités sont lancés automatiquement",
                directChild: Switch(
                  onChanged: (value) {},
                  value: true,
                ),
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
              ConfigItem(
                title: "Recevoir des notifications",
                description: "Les notifications vous sont envoyés",
                directChild: Switch(
                  onChanged: (value) {},
                  value: true,
                ),
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
              ConfigItem(
                title: "Mise à jour",
                description: "Mise à jour automatique de l'application",
                directChild: Switch(
                  onChanged: (value) {},
                  value: true,
                ),
                onPressed: () {},
              ),
              Divider(thickness: 0.7, height: 30, color: Colors.grey.shade300),
            ],
          ),
        ),
      ),
    );
  }
}
