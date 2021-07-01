import 'package:json_annotation/json_annotation.dart';

part 'collectionupdatedto.g.dart';

@JsonSerializable()
class CollectionUpdateDto {
  String name;
  bool ordered;
  List<String> seriesIds;
  CollectionUpdateDto({
    required this.name,
    required this.ordered,
    required this.seriesIds,
  });

  factory CollectionUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionUpdateDtoToJson(this);
}
