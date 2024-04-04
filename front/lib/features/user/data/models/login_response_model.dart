import 'package:front/features/user/domain/entities/LoginResponseEntity.dart';
import 'package:hive/hive.dart';

part 'login_response_model.g.dart'; // Generated part file for Hive

@HiveType(typeId: 0) // TypeId is a unique identifier for the Hive model
class LoginResponseModel extends HiveObject {
  @HiveField(0)
  late String message;

  @HiveField(1)
  late String? data;

  LoginResponseModel({
    required this.message,
    this.data,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final tab = <String, dynamic>{};
    tab["message"] = message;
    tab["data"] = data;

    return tab;
  }

  LoginResponseEntity LoginResponseModelToEntity(
      LoginResponseModel LoginResponseModel) {
    return LoginResponseEntity(
        message: LoginResponseModel.message!, data: LoginResponseModel.data!);
  }

  LoginResponseModel LoginResponseEntityToModel(
      LoginResponseEntity LoginResponseEntity) {
    return LoginResponseModel(
      message: LoginResponseEntity.message!,
      data: LoginResponseEntity.data!,
    );
  }
}
