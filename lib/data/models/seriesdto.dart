import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/bookmetadataaggregationdto.dart';
import 'package:klutter/data/models/seriesmetadatadto.dart';

part 'seriesdto.g.dart';

@JsonSerializable()
class SeriesDto {
  String id;
  String libraryId;
  String name;
  String url;
  DateTime created;
  DateTime lastModified;
  DateTime fileLastModified;
  int booksCount;
  int booksReadCount;
  int booksUnreadCount;
  int booksInProgressCount;
  SeriesMetadataDto metadata;
  BookMetadataAggregationDto booksMetadata;
  SeriesDto({
    required this.id,
    required this.libraryId,
    required this.name,
    required this.url,
    required this.created,
    required this.lastModified,
    required this.fileLastModified,
    required this.booksCount,
    required this.booksReadCount,
    required this.booksUnreadCount,
    required this.booksInProgressCount,
    required this.metadata,
    required this.booksMetadata,
  });

  factory SeriesDto.fromJson(Map<String, dynamic> json) =>
      _$SeriesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesDtoToJson(this);
}
