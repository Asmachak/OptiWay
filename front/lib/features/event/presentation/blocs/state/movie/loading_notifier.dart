import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/infrastructure/exceptions/http_exception.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/blocs/state/movie/loading_state.dart';

class LoadingNotifier extends StateNotifier<LoadingMovieState> {
  LoadingNotifier() : super(const LoadingMovieState.initial());

  Future<void> getEventsByParking(String parkingName) async {
    state = const LoadingMovieState.loading();
    try {
      String jsonString = await rootBundle.loadString('assets/movie_data.json');
      List<dynamic> jsonList = jsonDecode(jsonString);

      List<MovieModel> items =
          jsonList.map((json) => MovieModel.fromJson(json)).toList();

      List<MovieModel> matchesParking = items.where((movie) {
        // Check direct parkings
        bool matchesDirectParking = movie.parkings.any((parking) {
          return parking[0]
              .toString()
              .toLowerCase()
              .contains(parkingName.toLowerCase());
        });

        // Check cinemas' parkings
        bool matchesCinemaParking = movie.cinemas.any((cinema) {
          return cinema["parking"].any((parking) {
            return parking[0]
                .toString()
                .toLowerCase()
                .contains(parkingName.toLowerCase());
          });
        });

        return matchesDirectParking || matchesCinemaParking;
      }).toList();

      state = LoadingMovieState.eventLoaded(moviesList: matchesParking);
    } catch (e) {
      state = LoadingMovieState.failure(
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
