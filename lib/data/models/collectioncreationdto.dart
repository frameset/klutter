import 'package:json_annotation/json_annotation.dart';

part 'collectioncreationdto.g.dart';

@JsonSerializable()
class CollectionCreationDto {
  String name;
  bool ordered;
  List<String> seriesids;

  CollectionCreationDto(
      {required this.name, required this.ordered, required this.seriesids});

  factory CollectionCreationDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionCreationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionCreationDtoToJson(this);
}
