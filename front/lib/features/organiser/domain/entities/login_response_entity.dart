import 'package:front/features/organiser/data/models/login_response_organiser_model.dart';

class LoginResponseOragniserEntity {
  late final String message;
  late final String? data;

  LoginResponseOragniserEntity({
    required this.message,
    this.data,
  });

  LoginResponseOragniserEntity.fromJson(Map<String, dynamic> json) {
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
  LoginResponseOrganiserModel toModel() {
    return LoginResponseOrganiserModel(
      message: message,
      data: data,
    );
  }

  // Static method to convert model to entity
  static LoginResponseOragniserEntity fromModel(
      LoginResponseOrganiserModel model) {
    return LoginResponseOragniserEntity(
      message: model.message,
      data: model.data,
    );
  }
}
