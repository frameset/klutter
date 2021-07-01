import 'package:json_annotation/json_annotation.dart';

part 'sharedlibrarydto.g.dart';

@JsonSerializable()
class SharedLibraryDto {
  String id;

  SharedLibraryDto({
    required this.id,
  });
  factory SharedLibraryDto.fromJson(Map<String, dynamic> json) =>
      _$SharedLibraryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SharedLibraryDtoToJson(this);
}
