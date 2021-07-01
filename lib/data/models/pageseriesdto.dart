import 'package:json_annotation/json_annotation.dart';

import 'package:klutter/data/models/pageable.dart';
import 'package:klutter/data/models/seriesdto.dart';
import 'package:klutter/data/models/sort.dart';

part 'pageseriesdto.g.dart';

@JsonSerializable()
class PageSeriesDto {
  int? totalPages;
  int? totalElements;
  bool? first;
  Sort? sort;
  Pageable? pageable;
  int? numberOfElements;
  bool? last;
  int? size;
  List<SeriesDto>? content;
  int? number;
  bool? empty;

  PageSeriesDto({
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

  factory PageSeriesDto.fromJson(Map<String, dynamic> json) =>
      _$PageSeriesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PageSeriesDtoToJson(this);
}
