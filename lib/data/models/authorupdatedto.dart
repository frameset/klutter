import 'package:json_annotation/json_annotation.dart';

part 'authorupdatedto.g.dart';

@JsonSerializable()
class AuthorUpdateDto {
  String name;
  String role;
  AuthorUpdateDto({
    required this.name,
    required this.role,
  });

  factory AuthorUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorUpdateDtoToJson(this);
}
