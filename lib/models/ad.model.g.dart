// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) => Ad(
      id: json['id'] as String,
      ad_type: json['ad_type'] as String,
      content: json['content'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'id': instance.id,
      'ad_type': instance.ad_type,
      'content': instance.content,
    };

AdVideoContent _$AdVideoContentFromJson(Map<String, dynamic> json) =>
    AdVideoContent(
      link: json['link'] as String,
    );

Map<String, dynamic> _$AdVideoContentToJson(AdVideoContent instance) =>
    <String, dynamic>{
      'link': instance.link,
    };

AdStoreContent _$AdStoreContentFromJson(Map<String, dynamic> json) =>
    AdStoreContent(
      app_logo: json['app_logo'] as String,
      playstore_link: json['playstore_link'] as String?,
      appstore_link: json['appstore_link'] as String?,
    );

Map<String, dynamic> _$AdStoreContentToJson(AdStoreContent instance) =>
    <String, dynamic>{
      'app_logo': instance.app_logo,
      'playstore_link': instance.playstore_link,
      'appstore_link': instance.appstore_link,
    };
