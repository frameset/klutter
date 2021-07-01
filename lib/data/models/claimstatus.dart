import 'package:json_annotation/json_annotation.dart';

part 'claimstatus.g.dart';

@JsonSerializable()
class ClaimStatus {
  bool isClaimed;
  ClaimStatus({
    required this.isClaimed,
  });
  factory ClaimStatus.fromJson(Map<String, dynamic> json) =>
      _$ClaimStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimStatusToJson(this);
}
