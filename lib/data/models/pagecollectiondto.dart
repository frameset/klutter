import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/collectiondto.dart';
import 'package:klutter/data/models/pageable.dart';
import 'package:klutter/data/models/sort.dart';

part 'pagecollectiondto.g.dart';

@JsonSerializable()
class PageCollectionDto {
  int? totalPages;
  int? totalElements;
  bool? first;
  Sort? sort;
  Pageable? pageable;
  int? numberOfElements;
  bool? last;
  int? size;
  List<CollectionDto>? content;
  int? number;
  bool? empty;

  PageCollectionDto({
    this.totalPages,
    this.totalElements,
    this.first,
    this.sort,
    this.pageable,
    this.numberOfElements,
    this.last,
    this.size,
    this.content,
    this.number,
    this.empty,
  });

  factory PageCollectionDto.fromJson(Map<String, dynamic> json) =>
      _$PageCollectionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PageCollectionDtoToJson(this);
}
