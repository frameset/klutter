import 'package:json_annotation/json_annotation.dart';

enum Status {
  @JsonValue('ENDED')
  ended,
  @JsonValue('ONGOING')
  ongoing,
  @JsonValue('ABANDONED')
  abandoned,
  @JsonValue('HIATUS')
  hiatus
}
