import 'package:json_annotation/json_annotation.dart';

part 'librarydto.g.dart';
//comment

@JsonSerializable()
class LibraryDto {
  String id;
  String name;
  String root;
  bool importComicInfoBook;
  bool importComicInfoSeries;
  bool importComicInfoCollection;
  bool importComicInfoReadList;
  bool importEpubBook;
  bool importEpubSeries;
  bool importLocalArtwork;
  bool scanForceModifiedTime;
  bool scanDeep;

  LibraryDto(
      {required this.id,
      required this.name,
      required this.root,
      required this.importComicInfoBook,
      required this.importComicInfoCollection,
      required this.importComicInfoSeries,
      required this.importComicInfoReadList,
      required this.importEpubBook,
      required this.importEpubSeries,
      required this.importLocalArtwork,
      required this.scanForceModifiedTime,
      required this.scanDeep});

  factory LibraryDto.fromJson(Map<String, dynamic> json) =>
      _$LibraryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryDtoToJson(this);
}
