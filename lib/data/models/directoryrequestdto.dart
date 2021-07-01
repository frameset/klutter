import 'package:json_annotation/json_annotation.dart';

part 'directoryrequestdto.g.dart';

@JsonSerializable()
class DirectoryRequestDto {
  String path;

  DirectoryRequestDto({required this.path});

  factory DirectoryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DirectoryRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DirectoryRequestDtoToJson(this);
}
