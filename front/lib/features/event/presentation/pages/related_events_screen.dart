import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/movie_provider.dart';
import 'package:front/features/event/presentation/blocs/state/movie/movie_notifier.dart';
import 'package:front/features/event/presentation/widgets/movie_widget.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/features/reservation/presentation/blocs/reservation_providers.dart';
import 'package:front/features/reservation/presentation/blocs/state/reservation/reservation_notifier.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:lottie/lottie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

@RoutePage()
class RelatedEventScreen extends ConsumerStatefulWidget {
  const RelatedEventScreen({Key? key}) : super(key: key);

  @override
  _RelatedEventScreenState createState() => _RelatedEventScreenState();
}

class _RelatedEventScreenState extends ConsumerState<RelatedEventScreen> {
  late ReservationNotifier reservationNotifier;
  late MovieNotifier eventNotifier;
  late dynamic json;

  @override
  void initState() {
    super.initState();
    // Defer the initialization of providers to after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reservationNotifier = ref.read(reservationNotifierProvider.notifier);
      eventNotifier = ref.read(MovieNotifierProvider.notifier);
      json = ref.read(reservationParkingDataProvider);

      if (json != null && json["parking"] != null) {
        print("Parking Name: ${json["parking"]}");
        ref
            .read(loadingMovieNotifierProvider.notifier)
            .getEventsByParking(json["parking"]);
      } else {
        print("json or json['parking'] is null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = ref.watch(loadingMovieNotifierProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          "Related Events",
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  loadingState.when(
                    initial: () => const SliverToBoxAdapter(
                      child: Center(child: Text('No data')),
                    ),
                    loading: () => const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    failure: (exception) => SliverToBoxAdapter(
                      child: Center(child: Text('Error: $exception')),
                    ),
                    loaded: (moviesList) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final movie = moviesList[index];
                          return MovieWidget(
                              movie: movie,
                              onPress: () {
                                json["idevent"] = movie.id;
                                print(
                                    "Updated JSON: $json"); // Ensure this is printed
                                AutoRouter.of(context)
                                    .push(MovieDetailRoute(movie: movie));
                              });
                        },
                        childCount: moviesList.length,
                      ),
                    ),
                    eventLoaded: (moviesList) {
                      final filteredMovies = moviesList.where((movie) {
                        final matchesTitle = movie.title
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase());
                        return matchesTitle;
                      }).toList();

                      if (filteredMovies.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No Related Events for this parking',
                                    style: TextStyle(fontSize: 25),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Center(
                                child: Lottie.asset(
                                    "assets/animations/events.json"),
                              ),
                            ],
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final movie = filteredMovies[index];
                            return MovieWidget(
                              movie: movie,
                              onPress: () {
                                json["idevent"] = movie.id;
                                print(
                                    "Updated JSON: $json"); // Ensure this is printed
                                AutoRouter.of(context)
                                    .push(MovieDetailRoute(movie: movie));
                              },
                            );
                          },
                          childCount: filteredMovies.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
