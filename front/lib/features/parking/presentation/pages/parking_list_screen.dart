import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/core/loading.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/features/parking/presentation/widgets/parking_widget.dart';
import 'package:front/routes/app_routes.gr.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class ParkingListScreen extends ConsumerStatefulWidget {
  const ParkingListScreen({Key? key}) : super(key: key);

  @override
  _ParkingListScreenState createState() => _ParkingListScreenState();
}

class _ParkingListScreenState extends ConsumerState<ParkingListScreen> {
  late ScrollController scrollController;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
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
    final searchQuery = ref.watch(searchQueryProvider);
    final state = ref.watch(parkingNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
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
                  fillColor:
                      const Color.fromARGB(255, 138, 151, 216).withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Find Your parking",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: const Color.fromARGB(255, 45, 56, 116),
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),
            state.when(
              initial: () {
                return const Text("initial");
              },
              loading: () {
                return Center(child: loadingWidget());
              },
              loaded: (parkings) {
                return SingleChildScrollView(
                  child: Column(
                    children: parkings
                        .where((parking) =>
                            parking.parkingName!
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()) ||
                            parking.adress!
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                        .map((parking) {
                      return ParkingWidget(
                        averageRate: parking.averageRate ?? "",
                        title: parking.parkingName ?? '',
                        adress: parking.adress ?? '',
                        onPress: () {
                          AutoRouter.of(context).push(
                            ParkingDetailsRoute(
                                id: parking.id!,
                                capacity: parking.capacity!,
                                parkingName: parking.parkingName!,
                                description: parking.description!,
                                location: parking.location ?? "",
                                mailContact: parking.mailContact!,
                                phoneContact: parking.phoneContact!,
                                adress: parking.adress!),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              failure: (exception) {
                return Text("$exception");
              },
              success: () {
                return const Text("success");
              },
            ),
          ],
        ),
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
                  Color.fromARGB(255, 166, 173, 211).withOpacity(0.5),
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_upward),
              elevation: 0,
            )
          : null,
    );
  }
}
