import 'package:front/features/admin/domain/entities/admin_entity.dart';
import 'package:hive/hive.dart';

part 'admin_model.g.dart';

@HiveType(typeId: 4)
class AdminModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? token;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String? password;

  @HiveField(6)
  final String? photo;

  @HiveField(7)
  final String? lastName;

  @HiveField(8)
  final String? address;

  @HiveField(9)
  final String? city;

  @HiveField(10)
  final String? country;

  @HiveField(11)
  final String? deviceId;

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
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

  AdminModel(
      {this.id,
      this.name,
      this.email,
      this.token,
      this.phone,
      this.password,
      this.photo,
      this.lastName,
      this.address,
      this.city,
      this.country,
      this.deviceId});

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
}

AdminEntity adminModelToEntity(AdminModel adminModel) {
  return AdminEntity(
    id: adminModel.id ?? "",
    name: adminModel.name! ?? "",
    email: adminModel.email! ?? "",
    lastName: adminModel.lastName! ?? "",
    phone: adminModel.phone! ?? "",
    photo: adminModel.photo! ?? "",
    password: adminModel.password! ?? "",
    address: adminModel.address! ?? "",
    token: adminModel.token! ?? "",
    city: adminModel.city! ?? "",
    country: adminModel.country! ?? "",
    deviceId: adminModel.deviceId! ?? "",
  );
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
