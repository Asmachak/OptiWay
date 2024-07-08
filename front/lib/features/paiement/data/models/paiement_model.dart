import 'package:json_annotation/json_annotation.dart';

part 'paiement_model.g.dart';

@JsonSerializable()
class PaiementModel {
  final String paymentIntent;
  final String ephemeralKey;
  final String customer;
  final String publishableKey;

  PaiementModel(
      {required this.paymentIntent,
      required this.ephemeralKey,
      required this.customer,
      required this.publishableKey});

   factory PaiementModel.fromJson(Map<String, dynamic> json) =>
      _$PaiementModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaiementModelToJson(this);
}
