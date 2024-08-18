import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/promo/presentation/blocs/check_promo_provider.dart';

class MovieWidget extends ConsumerStatefulWidget {
  const MovieWidget({
    Key? key,
    required this.movie,
    required this.onPress,
  }) : super(key: key);

  final MovieModel movie;
  final void Function()? onPress;

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends ConsumerState<MovieWidget> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    String formattedDirectors = widget.movie.directors.join(', ');

    return GestureDetector(
      onTap: widget.onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: double.maxFinite,
            height: 180,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 149, 160, 214).withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: widget.movie.image_url.isNotEmpty
                                ? Image.network(
                                    widget.movie.image_url,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey,
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                          ),
                        ),
                        if (widget.movie.rating != "null")
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 218, 216, 216)
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 19.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    widget.movie.rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 35, 42, 83)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.movie.genres,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          if (widget.movie.directors.isNotEmpty) ...[
                            Text(
                              "Directed by : $formattedDirectors",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 35, 42, 83)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
