import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/bookdto.dart';
import 'package:klutter/data/models/pageable.dart';

import 'sort.dart';

part 'pagebookdto.g.dart';

@JsonSerializable()
class PageBookDto {
  int? totalPages;
  int? totalElements;
  bool? first;
  Sort? sort;
  Pageable? pageable;
  int? numberOfElements;
  bool? last;
  int? size;
  List<BookDto>? content;
  int? number;
  bool? empty;

  PageBookDto({
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

  factory PageBookDto.fromJson(Map<String, dynamic> json) =>
      _$PageBookDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PageBookDtoToJson(this);
}
