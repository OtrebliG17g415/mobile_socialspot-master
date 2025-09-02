import 'package:flutter/material.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/pages/ad/form_ad.page.dart';
import 'package:social_spot/pages/ad/store_ad.page.dart';
import 'package:social_spot/pages/ad/video_ad.page.dart';

class AdView extends StatelessWidget {
  const AdView({super.key, required this.ad});

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: appPrimaryColor,
      //   title: SvgPicture.asset(hubCityLogo, width: 80),
      //   centerTitle: true,
      //   leading: const SizedBox(),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: switch (ad.ad_type) {
            "in_app_video" => VideoAdPage(ad: ad),
            "store_app" => StoreAdPage(ad: ad),
            "survey_form" => FormAdPage(ad: ad),
            String() => const Scaffold(),
          },
        ),
      ),
    );
  }
}
