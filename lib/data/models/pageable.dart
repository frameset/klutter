import 'package:json_annotation/json_annotation.dart';
import 'package:klutter/data/models/sort.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable {
  int? page;
  int? size;
  Sort? sort;

  Pageable({
    this.page,
    this.size,
    this.sort,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}
