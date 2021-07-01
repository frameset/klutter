import 'package:json_annotation/json_annotation.dart';

part 'pathdto.g.dart';

@JsonSerializable()
class PathDto {
  String type;
  String name;
  String path;

  PathDto({required this.type, required this.name, required this.path});

  factory PathDto.fromJson(Map<String, dynamic> json) =>
      _$PathDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PathDtoToJson(this);
}
