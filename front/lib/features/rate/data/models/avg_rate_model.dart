import 'package:json_annotation/json_annotation.dart';

part 'avg_rate_model.g.dart';

@JsonSerializable()
class RateAvgModel {
  double? averageRate;

  RateAvgModel({
    this.averageRate,
  });

  factory RateAvgModel.fromJson(Map<String, dynamic> json) =>
      _$RateAvgModelFromJson(json);
  Map<String, dynamic> toJson() => _$RateAvgModelToJson(this);
}
