import 'package:json_annotation/json_annotation.dart';

part 'libraryupdatedto.g.dart';

@JsonSerializable()
class LibraryUpdateDto {
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
  bool repairExtensions;
  bool convertToCbz;

  LibraryUpdateDto(
      {required this.name,
      required this.root,
      required this.importComicInfoBook,
      required this.importComicInfoCollection,
      required this.importComicInfoSeries,
      required this.importComicInfoReadList,
      required this.importEpubBook,
      required this.importEpubSeries,
      required this.importLocalArtwork,
      required this.scanForceModifiedTime,
      required this.scanDeep,
      required this.repairExtensions,
      required this.convertToCbz});

  factory LibraryUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$LibraryUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryUpdateDtoToJson(this);
}
