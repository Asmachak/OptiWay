import 'package:json_annotation/json_annotation.dart';
part 'promo_model.g.dart';

@JsonSerializable()
class PromoModel {
  String? id;
  String? createdAt;
  String? EndedAt;
  String? state;
  String? title;
  String? description;
  int? ticketNumber;
  double? percentageEvent; 
  double? percentageParking; 
  Map<String, dynamic>? event;

  PromoModel({
    this.id,
    this.createdAt,
    this.EndedAt,
    this.state,
    this.title,
    this.description,
    this.ticketNumber,
    this.percentageEvent,
    this.percentageParking,
    this.event,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) =>
      _$PromoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoModelToJson(this);
}
