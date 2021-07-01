import 'package:json_annotation/json_annotation.dart';

part 'readprogressupdatedto.g.dart';

@JsonSerializable()
class ReadProgressUpdateDto {
  int? page;
  bool? completed;
  ReadProgressUpdateDto({
    this.page,
    this.completed,
  });
  factory ReadProgressUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$ReadProgressUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReadProgressUpdateDtoToJson(this);
}
