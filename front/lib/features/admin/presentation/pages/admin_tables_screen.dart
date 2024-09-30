import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/data/models/movie/movie_model.dart';
import 'package:front/features/event/presentation/blocs/movie_provider.dart';
import 'package:front/features/organiser/domain/entities/organiser_entity.dart';
import 'package:front/features/organiser/presentation/blocs/get_organisers_providers.dart';
import 'package:front/features/parking/data/models/parking_model.dart';
import 'package:front/features/parking/presentation/blocs/parking_provider.dart';
import 'package:front/features/reclamation/data/models/reclamation_model.dart';
import 'package:front/features/reclamation/presentation/blocs/reclamation_provider.dart';
import 'package:front/features/user/presentation/blocs/get_users_providers.dart';
import 'package:front/features/user/domain/entities/user_entity.dart';

// StateProvider to manage the search term
final searchProvider = StateProvider<String>((ref) => '');

// StateProvider to manage sort order (A-Z or Z-A)
final sortOrderProvider =
    StateProvider<bool>((ref) => true); // true = A-Z, false = Z-A

@RoutePage()
class AdminTableScreen extends ConsumerStatefulWidget {
  const AdminTableScreen({super.key});

  @override
  _AdminTableScreenState createState() => _AdminTableScreenState();
}

class _AdminTableScreenState extends ConsumerState<AdminTableScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getAllUsersNotifierProvider.notifier).getUsers();
      ref.read(getAllOrganisersNotifierProvider.notifier).getOrganisers();
      ref.read(parkingNotifierProvider.notifier).getParkings();
      ref.read(MovieNotifierProvider.notifier).fetchItems();
      ref.read(reclamationNotifierProvider.notifier).getReclamations();
    });
  }

  // Set initial model to "Parkings"
  String selectedModel = 'Parkings';

  @override
  Widget build(BuildContext context) {
    final searchTerm = ref.watch(searchProvider); // Watch the search term
    final sortOrder =
        ref.watch(sortOrderProvider); // Watch the sort order (A-Z or Z-A)
    final getUserState = ref.watch(getAllUsersNotifierProvider);
    final getOrganiserState = ref.watch(getAllOrganisersNotifierProvider);
    final getParkingState = ref.watch(parkingNotifierProvider);
    final getMovieState = ref.watch(MovieNotifierProvider);
    final getReclamationState = ref.watch(reclamationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Table Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown to select the model (Users, Organizers, Parkings, etc.)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // DropdownButton inside Expanded to manage layout constraints
                  Expanded(
                    flex: 1, // Assign space for the dropdown
                    child: DropdownButton<String>(
                      value: selectedModel.isEmpty ? null : selectedModel,
                      isExpanded: true, // Make sure the dropdown expands to fit
                      hint: const Text('Select Model'),
                      items: [
                        'Users',
                        'Organizers',
                        'Parkings',
                        'Events',
                        "Reclamations"
                      ]
                          .map((model) => DropdownMenuItem<String>(
                                value: model,
                                child: Text(model),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedModel = value ?? '';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10), // Add space between widgets

                  // Search Bar inside Expanded to avoid layout issues
                  Expanded(
                    flex: 2, // Give more space to the search bar
                    child: TextField(
                      onChanged: (value) {
                        ref.read(searchProvider.notifier).state =
                            value.toLowerCase();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search by Name',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filter Button for Sorting
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (value) {
                      if (value == 'A-Z') {
                        ref.read(sortOrderProvider.notifier).state = true;
                      } else if (value == 'Z-A') {
                        ref.read(sortOrderProvider.notifier).state = false;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'A-Z',
                        child: Text('Sort A-Z'),
                      ),
                      const PopupMenuItem(
                        value: 'Z-A',
                        child: Text('Sort Z-A'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Handling the user state using Riverpod
            if (selectedModel == 'Users')
              getUserState.when(
                initial: () => const Center(child: Text('Select a model')),
                loading: () => const CircularProgressIndicator(),
                failure: (error) => Center(child: Text('Error: $error')),
                loaded: (users) {
                  // Apply filter and sort using search term and sort order
                  final filteredUsers = users
                      .where((user) =>
                          user.name.toLowerCase().contains(searchTerm))
                      .toList()
                    ..sort((a, b) => sortOrder
                        ? a.name.compareTo(b.name)
                        : b.name.compareTo(a.name));
                  final userData = convertUsersToMap(filteredUsers);
                  return _buildDataTable(selectedModel, userData);
                },
              ),

            // Handling the organiser state using Riverpod
            if (selectedModel == 'Organizers')
              getOrganiserState.when(
                initial: () => const Center(child: Text('Select a model')),
                loading: () => const CircularProgressIndicator(),
                failure: (error) => Center(child: Text('Error: $error')),
                loaded: (organizers) {
                  // Apply filter and sort using search term and sort order
                  final filteredOrganizers = organizers
                      .where((organizer) =>
                          organizer.name.toLowerCase().contains(searchTerm))
                      .toList()
                    ..sort((a, b) => sortOrder
                        ? a.name.compareTo(b.name)
                        : b.name.compareTo(a.name));
                  final organiserData =
                      convertOrganizersToMap(filteredOrganizers);
                  return _buildDataTable(selectedModel, organiserData);
                },
              ),

            // Handling the parking state using Riverpod
            if (selectedModel == 'Parkings')
              getParkingState.when(
                initial: () => const Center(child: Text('Select a model')),
                loading: () => const CircularProgressIndicator(),
                failure: (error) => Center(child: Text('Error: $error')),
                loaded: (parkings) {
                  // Apply filter and sort using search term and sort order
                  final filteredParkings = parkings
                      .where((parking) => parking.parkingName!
                          .toLowerCase()
                          .contains(searchTerm))
                      .toList()
                    ..sort((a, b) => sortOrder
                        ? a.parkingName!.compareTo(b.parkingName!)
                        : b.parkingName!.compareTo(a.parkingName!));
                  final parkingData = convertParkingsToMap(filteredParkings);
                  return _buildDataTable(selectedModel, parkingData);
                },
                success: () => const Center(child: Text('Select a model')),
              ),

            // Handling the movie state using Riverpod
            if (selectedModel == 'Events')
              getMovieState.when(
                initial: () => const Center(child: Text('Select a model')),
                loading: () => const CircularProgressIndicator(),
                failure: (error) => Center(child: Text('Error: $error')),
                loaded: (movies) {
                  // Apply filter and sort using search term and sort order
                  final filteredMovies = movies
                      .where((movie) =>
                          movie.title.toLowerCase().contains(searchTerm))
                      .toList()
                    ..sort((a, b) => sortOrder
                        ? a.title.compareTo(b.title)
                        : b.title.compareTo(a.title));
                  final movieData = convertMoviesToMap(filteredMovies);
                  return _buildDataTable(selectedModel, movieData);
                },
                eventLoaded: (List<MovieModel> moviesList) =>
                    const Center(child: Text('Select a model')),
              ),

            // Handling the reclamation state using Riverpod
            if (selectedModel == 'Reclamations')
              getReclamationState.when(
                initial: () => const Center(child: Text('Select a model')),
                loading: () => const CircularProgressIndicator(),
                failure: (error) => Center(child: Text('Error: $error')),
                loaded: (Reclamations) {
                  // Apply filter and sort using search term and sort order
                  final filteredReclamations = Reclamations.where(
                      (reclamation) => reclamation.title!
                          .toLowerCase()
                          .contains(searchTerm)).toList()
                    ..sort((a, b) => sortOrder
                        ? a.title!.compareTo(b.title!)
                        : b.title!.compareTo(a.title!));
                  final movieData =
                      convertReclamationsToMap(filteredReclamations);
                  return _buildDataTable(selectedModel, movieData);
                },
                success: (rec) => const Center(child: Text('Select a model')),
              ),
          ],
        ),
      ),
    );
  }

  // Convert UserEntity to Map<String, String> for DataTable
  List<Map<String, String>> convertUsersToMap(List<UserEntity> users) {
    return users.map((user) {
      return {
        'Name': user.name,
        'Last Name': user.lastName,
        'Email': user.email,
        'Phone': user.phone,
        'Address': user.address,
        'City': user.city,
        'Country': user.country,
      };
    }).toList();
  }

  // Convert OrganizerEntity to Map<String, String>> for DataTable
  List<Map<String, String>> convertOrganizersToMap(
      List<OrganiserEntity> organizers) {
    return organizers.map((organizer) {
      return {
        'Name': organizer.name,
        'Last Name': organizer.lastName,
        'Email': organizer.email,
        'Phone': organizer.phone,
        'Address': organizer.address,
        'City': organizer.city,
        'Country': organizer.country,
      };
    }).toList();
  }

  // Convert ParkingEntity to Map<String, String> for DataTable
  List<Map<String, String>> convertParkingsToMap(List<ParkingModel> parkings) {
    return parkings.map((parking) {
      return {
        'name': parking.parkingName ?? '',
        'Capacity': parking.capacity ?? '',
        'adress': parking.adress ?? '',
      };
    }).toList();
  }

  // Convert MovieEntity to Map<String, String> for DataTable
  List<Map<String, String>> convertMoviesToMap(List<MovieModel> movies) {
    return movies.map((movie) {
      return {
        'Title': movie.title,
        'Genre': movie.genres,
        'Rating': movie.rating.toString()
      };
    }).toList();
  }

// Convert MovieEntity to Map<String, String> for DataTable
  List<Map<String, String>> convertReclamationsToMap(
      List<ReclamationModel> reclamations) {
    return reclamations.map((reclamation) {
      return {
        'Title': reclamation.title ?? "",
        'Target Type': reclamation.targetType ?? "",
        'UserName': reclamation.userName ?? "",
        'OrganiserName': reclamation.organiserName ?? "",
        'eventName': reclamation.eventName ?? "",
        'ParkingName': reclamation.parkingName ?? "",
      };
    }).toList();
  }

  // Build a generic DataTable widget
  Widget _buildDataTable(String model, List<Map<String, String>> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: _buildColumns(model, data),
          rows: _buildRows(model, data),
        ),
      ),
    );
  }

  /// Build the column headers dynamically based on the selected model or loaded data
  List<DataColumn> _buildColumns(String model, List<Map<String, String>> data) {
    if (data.isEmpty) {
      return [];
    }

    // Extract the first row to get the keys (column names)
    List<DataColumn> columns = data.first.keys.map((key) {
      return DataColumn(
        label: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 100), // Set max column width
          child: Text(
            key,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      );
    }).toList();

    // If the model is Users or Organizers, add a column for the delete button
    if (model == 'Users' || model == 'Organizers') {
      columns.add(const DataColumn(
        label: Text('Action'),
      ));
    }

    return columns;
  }

// Build the rows dynamically based on the selected model or loaded data
  // Build the rows dynamically based on the selected model or loaded data
  List<DataRow> _buildRows(String model, List<Map<String, String>> data) {
    return data.map((row) {
      // Create a list of DataCells for the current row
      List<DataCell> cells = row.values.map((value) {
        return DataCell(
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 100, // Set max width for the content
            ),
            child: Text(
              value, // The value for the cell
              maxLines: 2, // Allow up to 2 lines
              overflow:
                  TextOverflow.ellipsis, // Show '...' for overflowing text
              softWrap: true, // Enable text wrapping
            ),
          ),
        );
      }).toList();

      // Add delete button if the model is Users or Organizers
      if (model == 'Users' || model == 'Organizers') {
        cells.add(
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmationDialog(context, model, row['Email']!);
              },
            ),
          ),
        );
      }

      return DataRow(cells: cells);
    }).toList();
  }

// Function to show the delete confirmation dialog with reason input
  void _showDeleteConfirmationDialog(
      BuildContext context, String model, String email) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please provide a reason for deletion:'),
              const SizedBox(height: 10),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final reason = reasonController.text.trim();

                // Ensure a reason is provided before proceeding
                if (reason.isEmpty) {
                  _showErrorDialog(context);
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                  _confirmDeletion(context, model, email, reason);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

// Function to confirm deletion
  void _confirmDeletion(
      BuildContext context, String model, String email, String reason) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete this item for the following reason?\n\n$reason'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform the delete action based on the model
                if (model == 'Users') {
                  _deleteUser(
                      email, reason); // Use the email or unique identifier
                } else if (model == 'Organizers') {
                  _deleteOrganiser(
                      email, reason); // Use the email or unique identifier
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

// Function to show an error dialog if no reason is provided
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please provide a reason for deletion.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

// Function to delete a user (with reason)
  void _deleteUser(String email, String reason) {
    // Implement your user deletion logic here
    // You can also log the deletion reason if needed
    // ref.read(getAllUsersNotifierProvider.notifier).deleteUserByEmail(email);
    print("User with email $email deleted for reason: $reason");
  }

// Function to delete an organiser (with reason)
  void _deleteOrganiser(String email, String reason) {
    // Implement your organiser deletion logic here
    // You can also log the deletion reason if needed
    // ref.read(getAllOrganisersNotifierProvider.notifier).deleteOrganiserByEmail(email);
    print("Organiser with email $email deleted for reason: $reason");
  }
}
