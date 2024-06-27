import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';

part 'movie_state.freezed.dart';

@freezed
abstract class MovieState with _$MovieState {
  const factory MovieState.initial() = Initial;
  const factory MovieState.loading() = Loading;
  const factory MovieState.failure(AppException exception) = Failure;
  const factory MovieState.loaded({required List<MovieModel> moviesList}) = Loaded;
}
