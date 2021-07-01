import 'package:json_annotation/json_annotation.dart';

part 'readlistdto.g.dart';

@JsonSerializable()
class ReadListDto {
  String id;
  String name;
  List<String> bookIds;
  DateTime createdDate;
  DateTime lastModifiedDate;
  bool filtered;

  ReadListDto(
      {required this.id,
      required this.name,
      required this.bookIds,
      required this.createdDate,
      required this.lastModifiedDate,
      required this.filtered});

  factory ReadListDto.fromJson(Map<String, dynamic> json) =>
      _$ReadListDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReadListDtoToJson(this);
}
