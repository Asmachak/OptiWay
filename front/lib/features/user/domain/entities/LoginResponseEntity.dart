import 'package:front/features/user/data/models/login_response_model.dart';

class LoginResponseEntity {
  late final String message;
  late final String? data;

  LoginResponseEntity({
    required this.message,
    this.data,
  });

  LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['message'] = message;
    json['data'] = data;
    return json;
  }

  // Method to convert entity to model
  LoginResponseModel toModel() {
    return LoginResponseModel(
      message: message,
      data: data,
    );
  }

  // Static method to convert model to entity
  static LoginResponseEntity fromModel(LoginResponseModel model) {
    return LoginResponseEntity(
      message: model.message,
      data: model.data,
    );
  }
}
