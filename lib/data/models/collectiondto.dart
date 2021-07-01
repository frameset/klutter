import 'package:json_annotation/json_annotation.dart';

part 'collectiondto.g.dart';

@JsonSerializable()
class CollectionDto {
  String id;
  String name;
  bool ordered;
  List<String> seriesIds;
  DateTime createdDate;
  DateTime lastModifiedDate;
  bool filtered;

  CollectionDto(
      {required this.id,
      required this.name,
      required this.ordered,
      required this.seriesIds,
      required this.createdDate,
      required this.lastModifiedDate,
      required this.filtered});

  factory CollectionDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionDtoToJson(this);
}
