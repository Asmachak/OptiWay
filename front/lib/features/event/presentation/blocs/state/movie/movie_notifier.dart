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
      // Load JSON data from assets
      String jsonString = await rootBundle.loadString('assets/movie_data.json');
      // Decode JSON string into a List<dynamic>
      List<dynamic> jsonList = jsonDecode(jsonString);

      // Check if JSON data is not null and is a List
      if (jsonList == null || jsonList is! List) {
        throw Exception("Invalid JSON data");
      }

      // Map JSON list to List<MovieModel>
      List<MovieModel> items =
          jsonList.map((json) => MovieModel.fromJson(json)).toList();

      // Update state to loaded with the parsed items
      state = MovieState.loaded(moviesList: items);
    } catch (e) {
      // Handle exceptions by updating state to failure
      state = MovieState.failure(
        AppException(
          e.toString(),
          message: "Failed to load movies: ${e.toString()}",
          statusCode: 1,
          identifier: 'MovieProvider',
        ),
      );
    }
  }
}
