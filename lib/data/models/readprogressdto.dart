import 'package:json_annotation/json_annotation.dart';

part 'readprogressdto.g.dart';

@JsonSerializable()
class ReadProgressDto {
  int page;
  bool completed;
  DateTime created;
  DateTime lastModified;

  ReadProgressDto({
    required this.page,
    required this.completed,
    required this.created,
    required this.lastModified,
  });

  factory ReadProgressDto.fromJson(Map<String, dynamic> json) =>
      _$ReadProgressDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReadProgressDtoToJson(this);
}
