import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/promo/data/models/promo_model.dart';
part 'promo_state.freezed.dart';

@freezed
abstract class PromoState with _$PromoState {
  const factory PromoState.initial() = Initial;
  const factory PromoState.loading() = Loading;
  const factory PromoState.loaded({required List<PromoModel> promos}) = Loaded;
  const factory PromoState.failure(AppException exception) = Failure;
}
