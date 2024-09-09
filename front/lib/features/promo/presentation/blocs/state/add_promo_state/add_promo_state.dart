import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
part 'add_promo_state.freezed.dart';

@freezed
abstract class AddPromoState with _$AddPromoState {
  const factory AddPromoState.initial() = Initial;
  const factory AddPromoState.loading() = Loading;
  const factory AddPromoState.success({required PromoModel promo}) = Success;
  const factory AddPromoState.failure(AppException exception) = Failure;
}
