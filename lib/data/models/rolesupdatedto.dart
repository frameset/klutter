import 'package:json_annotation/json_annotation.dart';

part 'rolesupdatedto.g.dart';

@JsonSerializable()
class RolesUpdateDto {
  List<String> roles;

  RolesUpdateDto({required this.roles});

  factory RolesUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$RolesUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RolesUpdateDtoToJson(this);
}
