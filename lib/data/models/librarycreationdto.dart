import 'package:json_annotation/json_annotation.dart';

part 'librarycreationdto.g.dart';

@JsonSerializable()
class LibraryCreationDto {
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

  LibraryCreationDto(
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
      required this.scanDeep});
  factory LibraryCreationDto.fromJson(Map<String, dynamic> json) =>
      _$LibraryCreationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryCreationDtoToJson(this);
}
