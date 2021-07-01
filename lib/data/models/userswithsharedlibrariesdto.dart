import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/sharedlibrarydto.dart';

part 'userswithsharedlibrariesdto.g.dart';

@JsonSerializable()
class UsersWithSharedLibrariesDto {
  String id;
  String email;
  List<String> roles;
  bool sharedAllLibraries;
  List<SharedLibraryDto> sharedLibraries;

  UsersWithSharedLibrariesDto({
    required this.id,
    required this.email,
    required this.roles,
    required this.sharedAllLibraries,
    required this.sharedLibraries,
  });

  factory UsersWithSharedLibrariesDto.fromJson(Map<String, dynamic> json) =>
      _$UsersWithSharedLibrariesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UsersWithSharedLibrariesDtoToJson(this);
}
