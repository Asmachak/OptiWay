import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';

part 'loading_state.freezed.dart';

@freezed
abstract class LoadingMovieState with _$LoadingMovieState {
  const factory LoadingMovieState.initial() = Initial;
  const factory LoadingMovieState.loading() = Loading;
  const factory LoadingMovieState.failure(AppException exception) = Failure;
  const factory LoadingMovieState.loaded({required List<MovieModel> moviesList}) =
      Loaded;
    const factory LoadingMovieState.eventLoaded({required List<MovieModel> moviesList}) =
      EventLoaded;
}
