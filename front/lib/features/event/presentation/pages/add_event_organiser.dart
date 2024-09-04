import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/event_provider.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_organiser_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';
import 'package:front/features/event/presentation/widgets/add_image.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AddEventScreen extends ConsumerStatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends ConsumerState<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _capacityController = TextEditingController();
  final _placeController = TextEditingController();
  final _endedAtController = TextEditingController();
  final _ratingController = TextEditingController();
  final _genresController = TextEditingController();
  final _typeController = TextEditingController();
  final _customTypeController = TextEditingController();
  final _customGenreController = TextEditingController();

  File? _selectedImageFile;
  String? _selectedType; // To store the selected type
  String? _selectedGenre; // To store the selected genre
  DateTime? _selectedEndDateTime; // To store the selected end date and time

  final List<String> _eventTypes = [
    'Movie',
    'Festival',
    'Concert',
    'Sport',
    'Educational',
    'Charity',
    'Amusement',
    'Other',
  ];

  final List<String> _eventGenres = [
    'Familial',
    'Needs Parental Control',
    'Forbidden to Children',
    'Public',
    'Other',
  ];

  // List to keep track of dynamic fields and their controllers (for key-value pairs)
  final List<Map<String, TextEditingController>> _customFieldControllers = [];
  final List<Widget> _additionalFields = [];
  late EventOrganiserNotifier eventNotifier;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _unitPriceController.dispose();
    _capacityController.dispose();
    _placeController.dispose();
    _endedAtController.dispose();
    _ratingController.dispose();
    _typeController.dispose();
    _genresController.dispose();
    _customTypeController.dispose();
    _customGenreController.dispose();
    for (var map in _customFieldControllers) {
      map['key']?.dispose();
      map['value']?.dispose();
    }
    super.dispose();
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    // Pick the date first
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Pick the time next
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedEndDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          // Combine the picked date and time into a DateTime object
          _selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          // Update the text field with the formatted date and time
          _endedAtController.text = "${_selectedEndDateTime!.toLocal()}"
              .split('.')[0]; // Formats as yyyy-MM-dd HH:mm
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImageFile == null) {
        // Show an error if the image is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return; // Stop submission
      }

      // Gather custom field values
      Map<String, String> customFieldValues = {};
      for (var map in _customFieldControllers) {
        String key = map['key']?.text ?? '';
        String value = map['value']?.text ?? '';
        if (key.isNotEmpty && value.isNotEmpty) {
          customFieldValues[key] = value;
        }
      }

      final eventData = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'image_file': _selectedImageFile, // Pass the File object
        'unit_price': double.tryParse(_unitPriceController.text) ?? 0,
        'capacity': int.tryParse(_capacityController.text) ?? 0,
        'place': _placeController.text,
        'endedAt': _selectedEndDateTime?.toIso8601String() ??
            '', // Use selected end date and time
        'rating': double.tryParse(_ratingController.text) ?? 0,
        'type': _selectedType == 'Other'
            ? _customTypeController.text
            : _selectedType,
        'genres': _selectedGenre == 'Other'
            ? _customGenreController.text
            : _selectedGenre,
        'additional_info': customFieldValues, // Include custom fields
      };

      // Submit the event data to backend or local storage here
      print(eventData); // Replace this with your submission logic
      eventNotifier.addEvent(
          GetIt.instance.get<OrganiserLocalDataSource>().currentOrganiser!.id!,
          eventData,
          _selectedImageFile!);

      // Clear the form after submission
      _formKey.currentState?.reset();
      setState(() {
        _selectedImageFile = null;
        _selectedType = null;
        _selectedGenre = null;
        _selectedEndDateTime = null;
        _additionalFields.clear();
        _customFieldControllers.clear();
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      hintText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    );
  }

  void _addNewField() {
    setState(() {
      // Create new controllers for key and value
      final keyController = TextEditingController();
      final valueController = TextEditingController();
      _customFieldControllers
          .add({'key': keyController, 'value': valueController});

      // Add a new Row with two TextFormField widgets (key and value)
      _additionalFields.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: keyController,
                  decoration: _buildInputDecoration(
                    'Key ${_customFieldControllers.length}',
                    Icons.key,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a key';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: valueController,
                  decoration: _buildInputDecoration(
                    'Value ${_customFieldControllers.length}',
                    Icons.edit,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    eventNotifier = ref.read(eventNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddImageWidget(
              onImageSelected: (imageFile) {
                setState(() {
                  _selectedImageFile = imageFile;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: _buildInputDecoration('Title', Icons.title),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: _buildInputDecoration(
                            'Description', Icons.description),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _unitPriceController,
                        keyboardType: TextInputType.number,
                        decoration: _buildInputDecoration(
                            'Unit Price', Icons.attach_money),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a unit price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _capacityController,
                        keyboardType: TextInputType.number,
                        decoration:
                            _buildInputDecoration('Capacity', Icons.people),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a capacity';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _placeController,
                        decoration: _buildInputDecoration('Place', Icons.place),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a place';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _endedAtController,
                        readOnly: true,
                        decoration: _buildInputDecoration(
                            'End Date & Time', Icons.calendar_today),
                        onTap: () => _selectEndDateTime(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an end date and time';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration:
                            _buildInputDecoration('Type', Icons.category),
                        value: _selectedType,
                        items: _eventTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a type';
                          }
                          return null;
                        },
                      ),
                      if (_selectedType == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextFormField(
                            controller: _customTypeController,
                            decoration: _buildInputDecoration(
                                'Enter custom type', Icons.category),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a custom type';
                              }
                              return null;
                            },
                          ),
                        ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: _buildInputDecoration(
                            'Genre', Icons.gesture_rounded),
                        value: _selectedGenre,
                        items: _eventGenres.map((String genre) {
                          return DropdownMenuItem<String>(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGenre = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a genre';
                          }
                          return null;
                        },
                      ),
                      if (_selectedGenre == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextFormField(
                            controller: _customGenreController,
                            decoration: _buildInputDecoration(
                                'Enter custom genre', Icons.gesture_rounded),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a custom genre';
                              }
                              return null;
                            },
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Render additional fields
                      ..._additionalFields,
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addNewField,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.indigo,
                          ),
                          child: const Text(
                            "Add Custom Field",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                                if (ref.watch(eventNotifierProvider)
                                    is Success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        padding: const EdgeInsets.all(16),
                                        height: 90,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: const Column(
                                          children: [
                                            Text(
                                              "Congrats!",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              " Your Event is added successfully!",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ),
                                  );
                                  AutoRouter.of(context)
                                      .push(const OrganiserEventRoute());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                backgroundColor: Colors.indigo,
                              ),
                              child: const Text(
                                "Add Event",
                                style: TextStyle(color: Colors.white),
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
