import 'package:json_annotation/json_annotation.dart';

part 'userdto.g.dart';

@JsonSerializable()
class UserDto {
  String id;
  String email;
  List<String> roles;

  UserDto({required this.id, required this.email, required this.roles});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
