import 'package:front/features/organiser/domain/entities/login_response_entity.dart';
import 'package:hive/hive.dart';

part 'admin_login_response_model.g.dart'; // Generated part file for Hive

@HiveType(typeId: 0) // TypeId is a unique identifier for the Hive model
class AdminLoginResponseModel extends HiveObject {
  @HiveField(0)
  late String message;

  @HiveField(1)
  late String? data;

  AdminLoginResponseModel({
    required this.message,
    this.data,
  });

  factory AdminLoginResponseModel.fromJson(Map<String, dynamic> json) {
    return AdminLoginResponseModel(
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

  factory AdminLoginResponseModel.fromEntity(
      LoginResponseOragniserEntity entity) {
    return AdminLoginResponseModel(
      message: entity.message,
      data: entity.data,
    );
  }
}
