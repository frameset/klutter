import 'package:json_annotation/json_annotation.dart';

part 'sharedlibrariesupdatedto.g.dart';

@JsonSerializable()
class SharedLibrariesUpdateDto {
  bool all;
  Set<String> libraryIds;

  SharedLibrariesUpdateDto({required this.all, required this.libraryIds});

  factory SharedLibrariesUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$SharedLibrariesUpdateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SharedLibrariesUpdateDtoToJson(this);
}
