import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/authordto.dart';

part 'bookmetadataaggregationdto.g.dart';

@JsonSerializable()
class BookMetadataAggregationDto {
  List<AuthorDto> authors;
  DateTime? releaseDate;
  String summary;
  String summaryNumber;
  DateTime created;
  DateTime lastModified;

  BookMetadataAggregationDto({
    required this.authors,
    this.releaseDate,
    required this.summary,
    required this.summaryNumber,
    required this.created,
    required this.lastModified,
  });

  factory BookMetadataAggregationDto.fromJson(Map<String, dynamic> json) =>
      _$BookMetadataAggregationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookMetadataAggregationDtoToJson(this);
}
