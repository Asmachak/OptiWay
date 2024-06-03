import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

part 'rate_state.freezed.dart';

@freezed
abstract class RateState with _$RateState {
  const factory RateState.initial() = Initial;
  const factory RateState.loading() = Loading;
  const factory RateState.failure(AppException exception) = Failure;
  const factory RateState.success({required RateModel rateModel}) = Success;
}
