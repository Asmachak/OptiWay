import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/blocs/movie_provider.dart';
import 'package:front/features/event/presentation/widgets/drop_down_widget.dart';
import 'package:front/features/event/presentation/widgets/movie_widget.dart';
import 'package:front/features/event/presentation/widgets/drop_down_widget.dart'
    as drop_down_widget;
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/routes/app_routes.gr.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  late ScrollController scrollController;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    // Fetch the items when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(MovieNotifierProvider.notifier).fetchItems();
      ref.read(parkingNotifierProvider.notifier).getParkings();
    });
    // Initialize the scrollController here
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset > 200) {
      if (!_showFab) {
        setState(() {
          _showFab = true;
        });
      }
    } else {
      if (_showFab) {
        setState(() {
          _showFab = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(MovieNotifierProvider);
    final parkingState = ref.watch(parkingNotifierProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final type = ref.watch(typeProvider);
    final parkingProv = ref.watch(parkingProvider);
    final rating = ref.watch(ratingProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Align(
          alignment: Alignment.center,
          child: Text('Available Events'),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 64, 133),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 138, 151, 216)
                            .withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Find Your Event",
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: const Color.fromARGB(255, 45, 56, 116),
                      ),
                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).state = value;
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        drop_down_widget.DropdownMenu(
                          items: const [
                            "Movies",
                            "Festivals",
                            "Cultural events"
                          ],
                          title: "Event Type",
                          provider: typeProvider,
                        ),
                        const SizedBox(width: 10),
                        parkingState.maybeWhen(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          loaded: (parkings) {
                            final list = parkings
                                .map((parking) => parking.parkingName!)
                                .toList();
                            return drop_down_widget.DropdownMenu(
                              items: list,
                              title: "Related Parking",
                              provider: parkingProvider,
                            );
                          },
                          orElse: () => Container(),
                        ),
                        const SizedBox(width: 10),
                        drop_down_widget.DropdownMenu(
                          items: const [
                            "1.0",
                            "1.5",
                            "2.0",
                            "2.5",
                            "3.0",
                            "3.5",
                            "4.0",
                            "4.5",
                            "5.0"
                          ],
                          title: "Rating",
                          provider: ratingProvider,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          movieState.when(
            initial: () => const SliverToBoxAdapter(
              child: Center(child: Text('No data')),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            failure: (exception) => SliverToBoxAdapter(
              child: Center(child: Text('Error: $exception')),
            ),
            loaded: (moviesList) {
              final filteredMovies = moviesList.where((movie) {
                final matchesTitle = movie.title
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());

                final matchesParking = movie.parkings.any((parking) {
                  return parking[0].contains(parkingProv);
                });
                final matchesRating =
                    rating.isEmpty || movie.rating.toString() == rating;

                return matchesTitle && matchesParking && matchesRating;
              }).toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final movie = filteredMovies[index];
                    return MovieWidget(
                        movie: movie,
                        onPress: () {
                          AutoRouter.of(context)
                              .push(MovieDetailRoute(movie: movie));
                        });
                  },
                  childCount: filteredMovies.length,
                ),
              );
            },
            eventLoaded: (List<MovieModel> moviesList) {
              return const SizedBox();
            },
          ),
        ],
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              shape: const CircleBorder(),
              backgroundColor:
                  const Color.fromARGB(255, 166, 173, 211).withOpacity(0.5),
              foregroundColor: Colors.white,
              elevation: 0,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
