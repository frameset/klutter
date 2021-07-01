import 'package:json_annotation/json_annotation.dart';
import 'package:klutter/data/models/authordto.dart';

part 'bookmetadatadto.g.dart';

@JsonSerializable()
class BookMetadataDto {
  String title;
  bool titleLock;
  String summary;
  bool summaryLock;
  String number;
  bool numberLock;
  double numberSort;
  bool numberSortLock;
  DateTime? releaseDate;
  bool releaseDateLock;
  List<AuthorDto> authors;
  bool authorsLock;
  Set<String> tags;
  bool tagsLock;
  DateTime created;
  DateTime lastModified;

  BookMetadataDto({
    required this.title,
    required this.titleLock,
    required this.summary,
    required this.summaryLock,
    required this.number,
    required this.numberLock,
    required this.numberSort,
    required this.numberSortLock,
    this.releaseDate,
    required this.releaseDateLock,
    required this.authors,
    required this.authorsLock,
    required this.tags,
    required this.tagsLock,
    required this.created,
    required this.lastModified,
  });

  factory BookMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$BookMetadataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookMetadataDtoToJson(this);
}
