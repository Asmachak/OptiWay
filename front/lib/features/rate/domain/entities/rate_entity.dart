import 'dart:ffi';

import 'package:front/features/rate/data/models/rate_model.dart';

class RateEntity {
  final String id;
  final String user;
  final String reservation;
  final String? description;
  final double? parkingRate;
  final double? eventRate;

  RateEntity({
    required this.id,
    required this.reservation,
    required this.description,
    required this.user,
    required this.eventRate,
    required this.parkingRate,
  });

  factory RateEntity.fromJson(Map<String, dynamic> json) {
    return RateEntity(
      id: json['id'],
      reservation: json['reservation'],
      description: json['description'],
      user: json['user'],
      eventRate: json['eventRate'],
      parkingRate: json['parkingRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservation': reservation,
      'parkingRate': parkingRate,
      'eventRate': eventRate,
      'description': description,
      'user': user,
    };
  }

  RateModel rateEntityToModel(RateEntity rateEntity) {
    return RateModel(
      id: rateEntity.id,
      reservation: rateEntity.reservation,
      description: rateEntity.description,
      eventRate: rateEntity.eventRate,
      parkingRate: rateEntity.parkingRate,
      user: rateEntity.user,
    );
  }
}
