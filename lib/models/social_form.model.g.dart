// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_form.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialForm _$SocialFormFromJson(Map<String, dynamic> json) => SocialForm(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SocialFormField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SocialFormToJson(SocialForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'fields': instance.fields,
    };

SocialFormField _$SocialFormFieldFromJson(Map<String, dynamic> json) =>
    SocialFormField(
      type: json['type'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SocialFormFieldItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SocialFormFieldToJson(SocialFormField instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };

SocialFormFieldItem _$SocialFormFieldItemFromJson(Map<String, dynamic> json) =>
    SocialFormFieldItem(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SocialFormFieldItemToJson(
        SocialFormFieldItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
