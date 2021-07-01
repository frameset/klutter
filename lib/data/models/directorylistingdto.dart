import 'package:json_annotation/json_annotation.dart';
import 'package:klutter/data/models/pathdto.dart';

part 'directorylistingdto.g.dart';

@JsonSerializable()
class DirectoryListingDto {
  String parent;
  List<PathDto> directories;

  DirectoryListingDto({required this.parent, required this.directories});

  factory DirectoryListingDto.fromJson(Map<String, dynamic> json) =>
      _$DirectoryListingDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DirectoryListingDtoToJson(this);
}
