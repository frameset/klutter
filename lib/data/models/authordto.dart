import 'package:json_annotation/json_annotation.dart';

part 'authordto.g.dart';

@JsonSerializable()
class AuthorDto {
  String name;
  String role;

  AuthorDto({
    required this.name,
    required this.role,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorDtoToJson(this);
}
