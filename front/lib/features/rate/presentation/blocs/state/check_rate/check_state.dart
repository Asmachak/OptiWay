import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/rate_model.dart';

part 'check_state.freezed.dart';

@freezed
abstract class CheckRateState with _$CheckRateState {
  const factory CheckRateState.initial() = Initial;
  const factory CheckRateState.loading() = Loading;
  const factory CheckRateState.failure(AppException exception) = Failure;
  const factory CheckRateState.success({required RateModel rate}) = Success;
  const factory CheckRateState.failed() = Failed;
}
