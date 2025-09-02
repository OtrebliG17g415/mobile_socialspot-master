import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/models/social_form.model.dart';
import 'package:social_spot/widgets/text_input.widget.dart';

import '../helpers/constants.dart';

class SocialFormBuilder extends StatelessWidget {
  const SocialFormBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    var data = {"": ""};
    var formdata = SocialForm.fromJson(data);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          child: Column(
            children: [
              const Gap(30),
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                ),
              ),
              const Gap(16),
              buildForm(formdata),
            ],
          ),
        ),
      ),
    );
  }
}

dynamic buildForm(SocialForm form) {
  return buildFields(form.fields);
}

void buildFields(List<SocialFormField> fields) {
  List<Widget> data = [];
  for (SocialFormField field in fields) {
    switch (field.type) {
      case "textinput":
        data.add(TextInput(hintText: field.name));
        break;
      case "textarea":
        data.add(TextInput(hintText: field.name, maxLines: 4));
        break;
      case "checkbox":
        // var result = buildItems(field.items!, field.type);
        data.add(TextInput(hintText: field.name, maxLines: 4));
        break;
      default:
    }
  }
}

// List<dynamic> buildItems(List<SocialFormFieldItem> items, String type) {
//   var listItems = [];
//   switch (type) {
//     case "checkbox":
//       for (SocialFormFieldItem items in items) {

//       }
//       break;
//     default:
//       return listItems;
//   }
// }
