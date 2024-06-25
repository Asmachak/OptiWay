// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:front/core/infrastructure/exceptions/http_exception.dart';
// import 'package:front/features/event/data/models/movie_model.dart';
// import 'package:front/features/event/presentation/blocs/movie_state.dart';

// class ItemNotifier extends StateNotifier<MovieState> {
//   ItemNotifier() : super(const MovieState.initial());

//   Future<void> fetchItems() async {
//     state = const MovieState.loading();
//     try {
//       String jsonString = await rootBundle.loadString('assets/movie_data.json');
//       List<dynamic> jsonList = jsonDecode(jsonString);

//       // Print the JSON data for debugging
//       print(jsonList);

//       List<MovieModel> items =
//           jsonList.map((json) => MovieModel.fromJson(json)).toList();
//       state = MovieState.loaded(moviesList: items);
//     } catch (e) {
//       state = MovieState.failure(
//         AppException(
//           e.toString(),
//           message: e.toString(),
//           statusCode: 1,
//           identifier: '${e.toString()}\nMoviesProvider',
//         ),
//       );
//     }
//   }
// }

// final itemProvider = StateNotifierProvider<ItemNotifier, MovieState>((ref) {
//   return ItemNotifier();
// });

// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// Future<List<dynamic>> loadJsonData() async {
//   final String response = await rootBundle.loadString('assets/movie_data.json');
//   final data = await json.decode(response);
//   return data;
// }

// final movieDataProvider = FutureProvider<List<dynamic>>((ref) async {
//   return await loadJsonData();
// });

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/movie_model.dart';
import 'package:front/features/event/presentation/blocs/movie_state.dart';

class ItemNotifier extends StateNotifier<MovieState> {
  ItemNotifier() : super(const MovieState.initial());

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

final itemNotifierProvider =
    StateNotifierProvider<ItemNotifier, MovieState>((ref) {
  return ItemNotifier();
});
