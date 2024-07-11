import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/paiement/data/models/paiement_model.dart';

part 'paiement_state.freezed.dart';

@freezed
abstract class PaiementState with _$PaiementState {
  const factory PaiementState.initial() = Initial;
  const factory PaiementState.loading() = Loading;
  const factory PaiementState.failure(AppException exception) = Failure;
  const factory PaiementState.success({required PaiementModel paymentModel}) = Success;
}
