import 'package:json_annotation/json_annotation.dart';

part 'social_form.model.g.dart';

// Form
@JsonSerializable()
class SocialForm {
  final String id;
  final String title;
  final String? description;
  final List<SocialFormField> fields;

  SocialForm({
    required this.id,
    required this.title,
    this.description,
    required this.fields,
  });

  factory SocialForm.fromJson(Map<String, dynamic> json) =>
      _$SocialFormFromJson(json);

  Map<String, dynamic> toJson() => _$SocialFormToJson(this);
}

// Fields
@JsonSerializable()
class SocialFormField {
  final String type;
  final String id;
  final String name;
  final List<SocialFormFieldItem>? items;

  SocialFormField({
    required this.type,
    this.items,
    required this.id,
    required this.name,
  });

  factory SocialFormField.fromJson(Map<String, dynamic> json) =>
      _$SocialFormFieldFromJson(json);

  Map<String, dynamic> toJson() => _$SocialFormFieldToJson(this);
}

// Items
@JsonSerializable()
class SocialFormFieldItem {
  final String id;
  final String name;

  SocialFormFieldItem({
    required this.id,
    required this.name,
  });

  factory SocialFormFieldItem.fromJson(Map<String, dynamic> json) =>
      _$SocialFormFieldItemFromJson(json);

  Map<String, dynamic> toJson() => _$SocialFormFieldItemToJson(this);
}
