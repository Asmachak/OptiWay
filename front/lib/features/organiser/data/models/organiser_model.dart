import 'package:front/features/organiser/domain/entities/organiser_entity.dart';
import 'package:hive/hive.dart';

part 'organiser_model.g.dart';

@HiveType(typeId: 2)
class OrganiserModel {
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

  factory OrganiserModel.fromJson(Map<String, dynamic> json) {
    return OrganiserModel(
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

  OrganiserModel(
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

OrganiserEntity organiserModelToEntity(OrganiserModel organiserModel) {
  return OrganiserEntity(
    id: organiserModel.id ?? "",
    name: organiserModel.name ?? "",
    email: organiserModel.email ?? "",
    lastName: organiserModel.lastName ?? "",
    phone: organiserModel.phone ?? "",
    photo: organiserModel.photo ?? "",
    password: organiserModel.password ?? "",
    address: organiserModel.address ?? "",
    token: organiserModel.token ?? "",
    city: organiserModel.city ?? "",
    country: organiserModel.country ?? "",
    deviceId: organiserModel.deviceId ?? "",
  );
}

OrganiserModel organiserEntityToModel(OrganiserEntity organiserEntity) {
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
