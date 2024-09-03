import 'package:front/features/organiser/data/models/organiser_model.dart';

class OrganiserEntity {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String photo;
  final String address;
  final String city;
  final String country;
  late String token;
  late String deviceId;

  OrganiserEntity(
      {required this.token,
      required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      required this.photo,
      required this.address,
      required this.city,
      required this.country,
      required this.deviceId});

  factory OrganiserEntity.fromJson(Map<String, dynamic> json) {
    return OrganiserEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      lastName: json['last_name'],
      photo: json['photo'],
      phone: json['phone'],
      address: json['address'],
      password: json['password'],
      city: json['city'],
      country: json['country'],
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'photo': photo,
      'last_name': lastName,
      'phone': phone,
      'password': password,
      'address': address,
      'city': city,
      'country': country,
      'deviceId': deviceId,
    };
  }

  OrganiserModel OrganiserEntityToModel(OrganiserEntity organiserEntity) {
    return OrganiserModel(
      id: organiserEntity.id,
      name: organiserEntity.name,
      email: organiserEntity.email,
      token: organiserEntity.token,
      password: organiserEntity.password,
      phone: organiserEntity.phone,
      photo: organiserEntity.photo,
      lastName: organiserEntity.lastName,
      address: organiserEntity.address,
      city: organiserEntity.city,
      country: organiserEntity.country,
      deviceId: organiserEntity.deviceId,
    );
  }
}
