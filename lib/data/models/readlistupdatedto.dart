import 'package:json_annotation/json_annotation.dart';

part 'readlistupdatedto.g.dart';

@JsonSerializable()
class ReadListUpdateDto {
  String? name;
  List<String>? bookIds;

  ReadListUpdateDto({this.name, this.bookIds});

  factory ReadListUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$ReadListUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReadListUpdateDtoToJson(this);
}
