import 'package:json_annotation/json_annotation.dart';
import 'package:front/features/rate/domain/entities/rate_entity.dart';

part 'rate_model.g.dart';

@JsonSerializable()
class RateModel {
  String? id;
  String? user;
  String? reservation;
  String? description;
  double? parkingRate;
  double? eventRate;

  RateModel({
    this.id,
    this.reservation,
    this.user,
    this.description,
    this.eventRate,
    this.parkingRate,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    double? parkingRate;
    double? eventRate;

    if (json['parkingRate'] != null) {
      parkingRate = (json['parkingRate'] as num).toDouble();
    }

    if (json['eventRate'] != null) {
      eventRate = (json['eventRate'] as num).toDouble();
    }

    return RateModel(
      id: json['id'] as String?,
      reservation: json['reservation'] as String?,
      description: json['description'] as String?,
      user: json['user'] as String?,
      parkingRate: parkingRate,
      eventRate: eventRate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservation': reservation,
      'eventRate': eventRate,
      'parkingRate': parkingRate,
      'description': description,
      'user': user,
    };
  }

  static RateEntity rateModelToEntity(RateModel rate) {
    return RateEntity(
      id: rate.id!,
      reservation: rate.reservation!,
      description: rate.description!,
      parkingRate: rate.parkingRate!,
      eventRate: rate.eventRate!,
      user: rate.user!,
    );
  }

  RateModel rateEntityToModel(RateEntity rateEntity) {
    return RateModel(
      id: rateEntity.id,
      reservation: rateEntity.reservation,
      description: rateEntity.description,
      user: rateEntity.user,
      parkingRate: rateEntity.parkingRate,
      eventRate: rateEntity.eventRate,
    );
  }
}
