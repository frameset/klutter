import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/pageable.dart';
import 'package:klutter/data/models/readlistdto.dart';
import 'package:klutter/data/models/sort.dart';

part 'pagereadlistdto.g.dart';

@JsonSerializable()
class PageReadListDto {
  int? totalPages;
  int? totalElements;
  bool? first;
  Sort? sort;
  Pageable? pageable;
  int? numberOfElements;
  bool? last;
  int? size;
  List<ReadListDto>? content;
  int? number;
  bool? empty;

  PageReadListDto({
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

  factory PageReadListDto.fromJson(Map<String, dynamic> json) =>
      _$PageReadListDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PageReadListDtoToJson(this);
}
