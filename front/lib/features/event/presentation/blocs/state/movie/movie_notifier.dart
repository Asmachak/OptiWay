import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/movie_provider.dart';
import 'package:front/features/event/presentation/blocs/state/movie/movie_state.dart';

final MovieNotifierProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier();
});
