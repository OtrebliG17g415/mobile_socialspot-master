import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/utils.dart';
import 'package:social_spot/widgets/input_required.widget.dart';
import 'package:social_spot/widgets/text_input.widget.dart';

class FormInputItem extends StatelessWidget {
  const FormInputItem({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.required = false,
  });

  final String title;
  final int maxLines;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(
            title,
            style: const TextStyle(color: likeBlueColor),
          ),
          const Gap(6),
          required ? const InputRequired() : const SizedBox(),
        ]),
        const Gap(1),
        TextInput(
          hintText: "Votre adresse mail",
          maxLines: maxLines,
        ),
        const Gap(15),
      ],
    );
  }
}

class FormChoiceItem extends StatelessWidget {
  const FormChoiceItem({
    super.key,
    required this.type,
    required this.title,
    this.required = false,
    required this.items,
  });

  final String type;
  final String title;
  final bool required;
  final List items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            title,
            style: const TextStyle(color: likeBlueColor),
          ),
          const Gap(6),
          required ? const InputRequired() : const SizedBox(),
        ]),
        const Gap(1),
        ...generateChoices(type, items),
        const Gap(15),
      ],
    );
  }
}
