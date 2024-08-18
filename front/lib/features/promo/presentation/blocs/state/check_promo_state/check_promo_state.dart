import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
part 'check_promo_state.freezed.dart';

@freezed
abstract class CheckPromoState with _$CheckPromoState {
  const factory CheckPromoState.initial() = Initial;
  const factory CheckPromoState.loading() = Loading;
  const factory CheckPromoState.success({required PromoModel promo}) = Success;
  const factory CheckPromoState.failure(AppException exception) = Failure;
}
