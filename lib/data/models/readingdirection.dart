import 'package:json_annotation/json_annotation.dart';

enum ReadingDirection {
  @JsonValue('LEFT_TO_RIGHT')
  lefttoright,
  @JsonValue('RIGHT_TO_LEFT')
  righttoleft,
  @JsonValue('VERTICAL')
  vertical,
  @JsonValue('WEBTOON')
  webtoon
}
