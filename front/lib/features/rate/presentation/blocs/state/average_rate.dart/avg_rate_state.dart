import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/rate/data/models/avg_rate_model.dart';

part 'avg_rate_state.freezed.dart';

@freezed
abstract class AvgRateState with _$AvgRateState {
  const factory AvgRateState.initial() = Initial;
  const factory AvgRateState.loading() = Loading;
  const factory AvgRateState.failure(AppException exception) = Failure;
  const factory AvgRateState.success({required RateAvgModel rate}) = Success;
  const factory AvgRateState.failed() = Failed;
}
