
import 'package:front/features/user/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final String photo;

  @HiveField(7)
  final String lastName;

  @HiveField(8)
  final String address;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      lastName: json['last_name'],
      photo: json['photo'],
      phone: json['phone'],
      address: json['address'],
      password: json['password'],
    );
  }

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.token,
      required this.phone,
      required this.password,
      required this.photo,
      required this.lastName,
      required this.address});

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
    };
  }
}


UserEntity userModelToEntity(UserModel userModel) {
  return UserEntity(
      id: userModel.id ,
      name: userModel.name,
      email: userModel.email,
      lastName: userModel.lastName,
      phone: userModel.phone,
      photo: userModel.photo,
      password: userModel.password,
      address: userModel.address,
      token: userModel.token);
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
  );
}
