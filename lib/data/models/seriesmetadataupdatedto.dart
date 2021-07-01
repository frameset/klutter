import 'package:json_annotation/json_annotation.dart';
import 'readingdirection.dart';
import 'status.dart';

part 'seriesmetadataupdatedto.g.dart';

@JsonSerializable()
class SeriesMetadataUpdateDto {
  Status status;
  bool statusLock;
  String title;
  bool titleLock;
  String titleSort;
  bool titleSortLock;
  String summary;
  bool summaryLock;
  String publisher;
  bool publisherLock;
  bool readingDirectionLock;
  String language;
  bool languageLock;
  bool genresLock;
  bool tagsLock;
  Set<String> tags;
  ReadingDirection readingDirection;
  int ageRating;
  Set<String> genres;

  SeriesMetadataUpdateDto(
      {required this.status,
      required this.statusLock,
      required this.title,
      required this.titleLock,
      required this.titleSort,
      required this.titleSortLock,
      required this.summary,
      required this.summaryLock,
      required this.publisher,
      required this.publisherLock,
      required this.readingDirectionLock,
      required this.language,
      required this.languageLock,
      required this.genresLock,
      required this.tagsLock,
      required this.tags,
      required this.readingDirection,
      required this.ageRating,
      required this.genres});
  factory SeriesMetadataUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$SeriesMetadataUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesMetadataUpdateDtoToJson(this);
}
