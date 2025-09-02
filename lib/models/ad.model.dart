import 'package:json_annotation/json_annotation.dart';

part 'ad.model.g.dart';

//
@JsonSerializable()
class Ad {
  final String id;
  final String ad_type;
  final Map content;

  Ad({
    required this.id,
    required this.ad_type,
    required this.content,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}

@JsonSerializable()
class AdVideoContent {
  final String link;

  AdVideoContent({
    required this.link,
  });

  factory AdVideoContent.fromJson(Map<String, dynamic> json) =>
      _$AdVideoContentFromJson(json);

  Map<String, dynamic> toJson() => _$AdVideoContentToJson(this);
}

@JsonSerializable()
class AdStoreContent {
  final String app_logo;
  final String? playstore_link;
  final String? appstore_link;

  AdStoreContent({
    required this.app_logo,
    this.playstore_link,
    this.appstore_link,
  });

  factory AdStoreContent.fromJson(Map<String, dynamic> json) =>
      _$AdStoreContentFromJson(json);

  Map<String, dynamic> toJson() => _$AdStoreContentToJson(this);
}
