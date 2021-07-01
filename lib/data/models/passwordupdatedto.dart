import 'package:json_annotation/json_annotation.dart';

part 'passwordupdatedto.g.dart';

@JsonSerializable()
class PasswordUpdateDto {
  String password;

  PasswordUpdateDto({required this.password});

  factory PasswordUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordUpdateDtoToJson(this);
}
