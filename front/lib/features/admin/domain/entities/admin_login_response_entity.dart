import 'package:front/features/admin/data/models/admin_login_response_model.dart';

class AdminLoginResponseEntity {
  late final String message;
  late final String? data;

  AdminLoginResponseEntity({
    required this.message,
    this.data,
  });

  AdminLoginResponseEntity.fromJson(Map<String, dynamic> json) {
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
  AdminLoginResponseModel toModel() {
    return AdminLoginResponseModel(
      message: message,
      data: data,
    );
  }

  // Static method to convert model to entity
  static AdminLoginResponseEntity fromModel(AdminLoginResponseModel model) {
    return AdminLoginResponseEntity(
      message: model.message,
      data: model.data,
    );
  }
}
