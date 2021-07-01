import 'package:json_annotation/json_annotation.dart';

import 'authorupdatedto.dart';

part 'bookmetadataupdatedto.g.dart';

@JsonSerializable()
class BookMetadataUpdateDto {
  String? title;
  bool? titleLock;
  String? summary;
  bool? summaryLock;
  String? number;
  bool? numberLock;
  double? numberSort;
  bool? numberSortLock;
  bool? releaseDateLock;
  bool? authorsLock;
  bool? tagsLock;
  Set<String>? tags;
  AuthorUpdateDto? authors;
  DateTime? releaseDate;

  BookMetadataUpdateDto({
    this.title,
    this.titleLock,
    this.summary,
    this.summaryLock,
    this.number,
    this.numberLock,
    this.numberSort,
    this.numberSortLock,
    this.releaseDateLock,
    this.authorsLock,
    this.tagsLock,
    this.tags,
    this.authors,
    this.releaseDate,
  });

  factory BookMetadataUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$BookMetadataUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookMetadataUpdateDtoToJson(this);
}
