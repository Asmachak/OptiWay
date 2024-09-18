import 'package:front/features/admin/data/models/admin_model.dart';

class AdminEntity {
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

  AdminEntity(
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

  factory AdminEntity.fromJson(Map<String, dynamic> json) {
    return AdminEntity(
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

  AdminModel adminEntityToModel(AdminEntity adminEntity) {
    return AdminModel(
      id: adminEntity.id,
      name: adminEntity.name,
      email: adminEntity.email,
      token: adminEntity.token,
      password: adminEntity.password,
      phone: adminEntity.phone,
      photo: adminEntity.photo,
      lastName: adminEntity.lastName,
      address: adminEntity.address,
      city: adminEntity.city,
      country: adminEntity.country,
      deviceId: adminEntity.deviceId,
    );
  }
}
