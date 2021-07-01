import 'package:json_annotation/json_annotation.dart';

part 'seriesmetadatadto.g.dart';

@JsonSerializable()
class SeriesMetadataDto {
  String? status;
  bool statusLock;
  String title;
  bool titleLock;
  String titleSort;
  bool titleSortLock;
  String summary;
  bool summaryLock;
  String readingDirection;
  bool readingDirectionLock;
  String publisher;
  bool publisherLock;
  int? ageRating;
  bool ageRatingLock;
  String language;
  bool languageLock;
  Set<String> genres;
  bool genresLock;
  Set<String> tags;
  bool tagsLock;
  DateTime created;
  DateTime lastModified;

  SeriesMetadataDto({
    required this.status,
    required this.statusLock,
    required this.title,
    required this.titleLock,
    required this.titleSort,
    required this.titleSortLock,
    required this.summary,
    required this.summaryLock,
    required this.readingDirection,
    required this.readingDirectionLock,
    required this.publisher,
    required this.publisherLock,
    required this.ageRating,
    required this.ageRatingLock,
    required this.language,
    required this.languageLock,
    required this.genres,
    required this.genresLock,
    required this.tags,
    required this.tagsLock,
    required this.created,
    required this.lastModified,
  });

  factory SeriesMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$SeriesMetadataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SeriesMetadataDtoToJson(this);
}
