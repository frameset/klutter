import 'package:json_annotation/json_annotation.dart';

part 'usercreationdto.g.dart';

@JsonSerializable()
class UserCreationDto {
  String email;
  String password;
  List<String> roles;

  UserCreationDto(
      {required this.email, required this.password, required this.roles});

  factory UserCreationDto.fromJson(Map<String, dynamic> json) =>
      _$UserCreationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserCreationDtoToJson(this);
}
