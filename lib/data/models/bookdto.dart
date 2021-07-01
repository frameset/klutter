import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bookmetadatadto.dart';
import 'mediadto.dart';
import 'readprogressdto.dart';

part 'bookdto.g.dart';

@JsonSerializable()
class BookDto extends Equatable {
  final String id;
  final String seriesId;
  final String libraryId;
  final String name;
  final String url;
  final int number;
  final DateTime created;
  final DateTime lastModified;
  final DateTime fileLastModified;
  final int sizeBytes;
  final MediaDto media;
  final BookMetadataDto metadata;
  final ReadProgressDto? readProgress;

  BookDto({
    required this.id,
    required this.seriesId,
    required this.libraryId,
    required this.name,
    required this.url,
    required this.number,
    required this.created,
    required this.lastModified,
    required this.fileLastModified,
    required this.sizeBytes,
    required this.media,
    required this.metadata,
    required this.readProgress,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) =>
      _$BookDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BookDtoToJson(this);

  List<Object> get props => [id];
}
