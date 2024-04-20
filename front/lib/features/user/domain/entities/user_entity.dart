import 'package:front/features/user/data/models/user_model.dart';

class UserEntity {
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

  UserEntity(
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
      required this.country});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
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
    };
  }

  UserModel userEntityToModel(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      name: userEntity.name,
      email: userEntity.email,
      token: userEntity.token,
      password: userEntity.password,
      phone: userEntity.phone,
      photo: userEntity.photo,
      lastName: userEntity.lastName,
      address: userEntity.address,
      city: userEntity.city,
      country: userEntity.country,
    );
  }
}
