// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paiement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaiementModel _$PaiementModelFromJson(Map<String, dynamic> json) =>
    PaiementModel(
      paymentIntent: json['paymentIntent'] as String,
      ephemeralKey: json['ephemeralKey'] as String,
      customer: json['customer'] as String,
      publishableKey: json['publishableKey'] as String,
    );

Map<String, dynamic> _$PaiementModelToJson(PaiementModel instance) =>
    <String, dynamic>{
      'paymentIntent': instance.paymentIntent,
      'ephemeralKey': instance.ephemeralKey,
      'customer': instance.customer,
      'publishableKey': instance.publishableKey,
    };
