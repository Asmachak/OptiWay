import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/blocs/state/movie/movie_state.dart';

class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier() : super(const MovieState.initial());

  Future<void> fetchItems() async {
    state = const MovieState.loading();
    try {
      String jsonString = await rootBundle.loadString('assets/movie_data.json');
      List<dynamic> jsonList = jsonDecode(jsonString);

      List<MovieModel> items =
          jsonList.map((json) => MovieModel.fromJson(json)).toList();
      state = MovieState.loaded(moviesList: items);
    } catch (e) {
      state = MovieState.failure(
        AppException(
          e.toString(),
          message: e.toString(),
          statusCode: 1,
          identifier: '${e.toString()}\nMovieProvider',
        ),
      );
    }
  }
}
