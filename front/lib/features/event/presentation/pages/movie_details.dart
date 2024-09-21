import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/widgets/rating_bar_widget.dart';
import 'package:front/features/promo/presentation/blocs/check_promo_provider.dart';
import 'package:front/features/reservation/presentation/blocs/jsonDataProvider.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class MovieDetailScreen extends ConsumerStatefulWidget {
  final MovieModel movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the provider logic here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkpromoNotifierProvider.notifier).checkPromo(widget.movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final json = ref.read(reservationEventDataProvider);
    final jsonData = ref.read(reservationParkingDataProvider);
    final promoState = ref.watch(checkpromoNotifierProvider);

    // json['idevent'] = widget.movie.id;
    // jsonData['idevent'] = widget.movie.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        leading: IconButton(
          onPressed: () {
            //resetReservationProviders(ref);
            json["idevent"] = "";
            jsonData["idevent"] = "";
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Photo and Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.movie.image_url ?? '',
                      width: 180,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 180,
                          height: 200,
                          color: Colors.grey,
                          child: const Icon(Icons.error, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Movie Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Title
                        Text(
                          widget.movie.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Director
                        Text(
                          'Director: ${widget.movie.directors.join(", ") ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color.fromARGB(255, 83, 82, 82),
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Rating
                        RatingBarWidget(rate: widget.movie.rating ?? 0.0),
                        const SizedBox(height: 8),
                        // Promo Section
                        promoState.when(
                          loading: () => const CircularProgressIndicator(),
                          failure: (error) => Text('Error: $error'),
                          success: (promo) {
                            final int eventPromo =
                                promo?.percentageEvent?.toInt() ?? 0;
                            final int parkingPromo =
                                promo?.percentageParking?.toInt() ?? 0;

                            if (eventPromo > 0 || parkingPromo > 0) {
                              return Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  border:
                                      Border.all(color: Colors.red.shade300),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Promo Available!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (eventPromo > 0)
                                      Text(
                                        "$eventPromo% off on Events",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    if (parkingPromo > 0)
                                      Text(
                                        "$parkingPromo% off on Parking",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // No promo to display
                            }
                          },
                          initial: () {
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Movie Description
            if ((widget.movie.description ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.movie.description ?? '',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            // Release Date
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 8, 8, 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 60, 107, 145),
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Release Date: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.movie.additional_info['release_date'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 83, 82, 82),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 8, 8, 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.movie,
                    color: Color.fromARGB(255, 60, 107, 145),
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Genre : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.movie.genres ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 83, 82, 82),
                    ),
                  ),
                ],
              ),
            ),
            if ((widget.movie.additional_info['original_language'] ?? '') != '')
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 8, 8, 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag,
                      color: Color.fromARGB(255, 60, 107, 145),
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Original Language : ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.movie.additional_info['original_language'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 83, 82, 82),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 8, 8, 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.public,
                    color: Color.fromARGB(255, 60, 107, 145),
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Country : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.movie.additional_info['country'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 83, 82, 82),
                    ),
                  ),
                ],
              ),
            ),
            if ((json["idparking"] ?? '') == '' &&
                (jsonData["idparking"] ?? '') == '') ...[
              // Available Parking
              const Padding(
                padding: EdgeInsets.fromLTRB(13, 8, 8, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: Color.fromARGB(255, 60, 107, 145),
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Available Parkings :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Grid of Parkings
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 3.0, // Adjust as needed
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.movie.parkings.length, // Number of parkings
                  itemBuilder: (context, index) {
                    final parking = widget
                        .movie.parkings[index]; // Access the parking object

                    return GestureDetector(
                      onTap: () {
                        print('Parking $index tapped');
                        // Handle the parking tap logic, possibly navigate to a parking detail page
                        // Example:
                        // AutoRouter.of(context).push(ParkingDetailRoute(parking: parking));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Grey background
                            border: Border.all(
                                color:
                                    Colors.transparent), // Transparent border
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              parking ?? 'Unknown', // Display parking name
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            // Available Theaters
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 8, 8, 8),
              child: Row(
                children: [
                  Icon(
                    Icons.theater_comedy,
                    color: Color.fromARGB(255, 60, 107, 145),
                    size: 30,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Available Movie Theaters :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Grid of cinemas
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 3.0, // Adjust as needed
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.movie.cinemas.length,
                itemBuilder: (context, index) {
                  final cinema = widget.movie.cinemas[index];
                  final List parkings = cinema['parkings'] ?? [];
                  bool containsDesiredParking = true;
                  // Vérification si le parking existe dans la liste des parkings
                  if ((json["parking"] ?? '') != '') {
                    containsDesiredParking = parkings
                        .any((parking) => parking[0] == json["parking"]);
                  }
                  if (containsDesiredParking) {
                    return GestureDetector(
                      onTap: () {
                        print('movie $index tapped');
                        AutoRouter.of(context).push(MovieDetailCinemaRoute(
                            cinema: cinema['name'] ?? '', movie: widget.movie));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Grey background
                            border: Border.all(
                                color:
                                    Colors.transparent), // Transparent border
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              cinema["name"] ?? '',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Return an empty widget if the parking is not desired
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
