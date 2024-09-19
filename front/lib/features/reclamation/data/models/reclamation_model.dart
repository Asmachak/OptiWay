import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reclamation_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class ReclamationModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? targetType;

  @HiveField(3)
  final String? iduser; // Nullable

  @HiveField(4)
  final String? idorganiser; // Nullable

  @HiveField(5)
  final String? idevent; // Nullable

  @HiveField(6)
  final String? idparking; // Nullable

  @HiveField(7)
  final String? parkingName; // Nullable

  @HiveField(8)
  final String? eventName; // Nullable

  @HiveField(9)
  final String? userName; // Nullable

  @HiveField(10)
  final String? organiserName; // Nullable

  ReclamationModel(
      {this.id, // Optional and nullable
      this.title, // Optional and nullable
      this.targetType, // Optional and nullable
      this.iduser, // Nullable
      this.idorganiser, // Nullable
      this.idevent, // Nullable
      this.idparking,
      this.parkingName,
      this.eventName,
      this.userName,
      this.organiserName});

  // Factory constructor for creating a new instance from a map
  factory ReclamationModel.fromJson(Map<String, dynamic> json) =>
      _$ReclamationModelFromJson(json);

  // Method to convert this object to a JSON map
  Map<String, dynamic> toJson() => _$ReclamationModelToJson(this);
}
