import 'package:json_annotation/json_annotation.dart';

part 'pagedto.g.dart';

@JsonSerializable()
class PageDto {
  int number;
  String fileName;
  String mediaType;
  int? width;
  int? height;
  PageDto({
    required this.number,
    required this.fileName,
    required this.mediaType,
    this.width,
    this.height,
  });
  factory PageDto.fromJson(Map<String, dynamic> json) =>
      _$PageDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PageDtoToJson(this);
}
