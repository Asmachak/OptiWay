import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';

part 'cars_state.freezed.dart';

@freezed
abstract class CarBrandState with _$CarBrandState {
  const factory CarBrandState.initial() = Initial;
  const factory CarBrandState.loading() = Loading;
  const factory CarBrandState.loaded({required List<dynamic> cars}) =
      CarsLoaded;
  const factory CarBrandState.failure(AppException exception) = Failure;
}
