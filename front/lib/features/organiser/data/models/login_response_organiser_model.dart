import 'package:front/features/organiser/domain/entities/login_response_entity.dart';
import 'package:hive/hive.dart';

part 'login_response_organiser_model.g.dart'; // Generated part file for Hive

@HiveType(typeId: 0) // TypeId is a unique identifier for the Hive model
class LoginResponseOrganiserModel extends HiveObject {
  @HiveField(0)
  late String message;

  @HiveField(1)
  late String? data;

  LoginResponseOrganiserModel({
    required this.message,
    this.data,
  });

  factory LoginResponseOrganiserModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseOrganiserModel(
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": data,
    };
  }

  LoginResponseOragniserEntity toEntity() {
    return LoginResponseOragniserEntity(
      message: message,
      data: data ?? '',
    );
  }

  factory LoginResponseOrganiserModel.fromEntity(
      LoginResponseOragniserEntity entity) {
    return LoginResponseOrganiserModel(
      message: entity.message,
      data: entity.data,
    );
  }
}
