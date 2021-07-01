import 'package:json_annotation/json_annotation.dart';

part 'readlistcreationdto.g.dart';

@JsonSerializable()
class ReadListCreationDto {
  String name;
  List<String> bookIds;

  ReadListCreationDto({required this.name, required this.bookIds});

  factory ReadListCreationDto.fromJson(Map<String, dynamic> json) =>
      _$ReadListCreationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ReadListCreationDtoToJson(this);
}
