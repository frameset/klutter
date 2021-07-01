import 'package:json_annotation/json_annotation.dart';

part 'mediadto.g.dart';

@JsonSerializable()
class MediaDto {
  String status;
  String mediaType;
  int pagesCount;
  String comment;

  MediaDto({
    required this.status,
    required this.mediaType,
    required this.pagesCount,
    required this.comment,
  });

  factory MediaDto.fromJson(Map<String, dynamic> json) =>
      _$MediaDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MediaDtoToJson(this);
}
