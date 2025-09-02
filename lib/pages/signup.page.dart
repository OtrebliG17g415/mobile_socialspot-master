import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/helpers/routes/pages.dart';
import 'package:social_spot/widgets/custom_button.widget.dart';
import 'package:social_spot/widgets/input_required.widget.dart';
import 'package:social_spot/widgets/text_input.widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: SvgPicture.asset(
          hubCityLogo,
          width: 80,
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(50),
                    Text(
                      "Dites-nous un peu plus sur vous",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: likeBlueColor,
                      ),
                    ),
                    Gap(40),
                    Row(children: [
                      Text(
                        "Prénoms",
                        style: TextStyle(color: likeBlueColor),
                      ),
                      Gap(6),
                      InputRequired(),
                    ]),
                    Gap(3),
                    TextInput(hintText: "Vos prénoms"),
                    Gap(16),
                    Row(children: [
                      Text(
                        "Nom",
                        style: TextStyle(color: likeBlueColor),
                      ),
                      Gap(6),
                      InputRequired(),
                    ]),
                    Gap(3),
                    TextInput(hintText: "Votre nom"),
                    Gap(16),
                    Row(children: [
                      Text(
                        "Adresse mail",
                        style: TextStyle(color: likeBlueColor),
                      ),
                      Gap(6),
                      InputRequired(),
                    ]),
                    Gap(3),
                    TextInput(hintText: "Votre adresse mail"),
                  ],
                ),
              ),
            ),
            const Gap(30),
            // const PrivacyPolicy(),
            const Gap(20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                onPressed: () => Navigator.pushNamed(context, AppPage.home),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
