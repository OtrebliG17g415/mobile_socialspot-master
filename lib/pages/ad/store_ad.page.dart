import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/utils.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/viewmodels/home.viewmodel.dart';
import 'package:social_spot/widgets/custom_button.widget.dart';

class StoreAdPage extends ConsumerStatefulWidget {
  const StoreAdPage({super.key, required this.ad});

  final Ad ad;

  @override
  ConsumerState<StoreAdPage> createState() => _StoreAdPageState();
}

class _StoreAdPageState extends ConsumerState<StoreAdPage> {
  late Timer _timer;
  int _start = 30;
  bool isPlaying = true;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
          isPlaying = false;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          isPlaying
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: appPrimaryColor),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text(_start.toString())),
                  ),
                )
              : const Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.ad.content["app_logo"],
                        fit: BoxFit.scaleDown,
                        errorWidget: (context, url, error) {
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    widget.ad.content["app_name"],
                    style: GoogleFonts.ubuntu().copyWith(fontSize: 25),
                  ),
                  const Gap(5),
                  Text(
                    "L'application Syswoe de La comunauté WoeLab sur vos smartphones",
                    style: GoogleFonts.ubuntu().copyWith(
                      // fontSize: 1,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(20),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 2.6,
                      autoPlay: true,
                      onPageChanged: (index, reason) {},
                    ),
                    items: List.from(
                      (widget.ad.content["screenshots"] as List).map(
                        (item) => CachedNetworkImage(
                          imageUrl: widget.ad.content["screenshots"][0],
                          fit: BoxFit.scaleDown,
                          errorWidget: (context, url, error) => Container(),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Text(
                    "Télécharger sur playstore",
                    style: GoogleFonts.ubuntu().copyWith(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Icon(
                    Icons.arrow_downward,
                    size: 30,
                    color: appPrimaryColor,
                  ),
                  IconButton(
                    onPressed: () => utilsLaunchUrl(
                      widget.ad.content["playstore_link"],
                    ),
                    icon: SvgPicture.asset(playStoreIcon, width: 115),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          isPlaying
              ? const SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    title: "Terminer",
                    onPressed: () {
                      Navigator.pop(context);
                      ref.read(loginProvider.future);
                      // ref.read(loginProvider.future).then((value) {
                      //   if (value) Navigator.pop(context);
                      // });
                      // setState(() {
                      //   btnLoading = true;
                      //   ref.read(loginProvider.future).then((value) {
                      //     btnLoading = false;
                      //   });
                      // });
                    },
                  ),
                ),
          const Gap(10),
        ],
      ),
    );
  }
}
