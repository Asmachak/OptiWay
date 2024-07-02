import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/state/movie/loading_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/movie/loading_state.dart';
import 'package:front/features/event/presentation/blocs/state/movie/movie_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/movie/movie_state.dart';

final MovieNotifierProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier();
});

final loadingMovieNotifierProvider =
    StateNotifierProvider<LoadingNotifier, LoadingMovieState>((ref) {
  return LoadingNotifier();
});
