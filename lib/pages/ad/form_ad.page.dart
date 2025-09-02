import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/constants.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/viewmodels/home.viewmodel.dart';
import 'package:social_spot/widgets/app_form.widgets.dart';
import 'package:social_spot/widgets/custom_button.widget.dart';

class FormAdPage extends ConsumerStatefulWidget {
  const FormAdPage({super.key, required this.ad});

  final Ad ad;

  @override
  ConsumerState<FormAdPage> createState() => _FormAdPageState();
}

class _FormAdPageState extends ConsumerState<FormAdPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: appSecondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Image(
                      image: AssetImage(socialSpotLogo),
                      width: 200,
                    ),
                  ),
                  const Gap(15),
                  const Text(
                    "Formulaire: Notation de Social spot",
                    style: TextStyle(fontSize: 20, color: likeBlueColor),
                    maxLines: 2,
                  ),
                  const Gap(20),
                  const FormInputItem(title: "Votre prénom", required: true),
                  const FormInputItem(title: "Description", maxLines: 3),
                  const FormChoiceItem(
                    type: "checkbox",
                    required: true,
                    title: "Choix multiple",
                    items: ["Vendredi", "Lundi"],
                  ),
                  const FormChoiceItem(
                    type: "radiobox",
                    required: true,
                    title: "Sexe",
                    items: ["Masculin", "Féminin"],
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
              title: "Valider",
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
