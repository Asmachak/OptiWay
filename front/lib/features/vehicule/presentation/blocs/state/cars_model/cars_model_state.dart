import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'cars_model_state.freezed.dart';

@freezed
abstract class CarModelState with _$CarModelState {
  const factory CarModelState.initial() = Initial;
  const factory CarModelState.loading() = Loading;
  const factory CarModelState.loaded({required List<dynamic> cars}) =
      CarsLoaded;
  const factory CarModelState.failure(AppException exception) = Failure;
}
