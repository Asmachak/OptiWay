import 'dart:convert'; // For JSON encoding
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/event/presentation/blocs/event_provider.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_organiser_notifier.dart';
import 'package:front/features/event/presentation/blocs/state/event_organiser/event_state.dart';
import 'package:front/features/event/presentation/widgets/add_image.dart';
import 'package:front/features/organiser/data/data_sources/organiser_local_data_src.dart';
import 'package:get_it/get_it.dart';
import 'package:front/routes/app_routes.gr.dart';

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
  final _unitPriceController = TextEditingController();
  final _capacityController = TextEditingController();
  final _placeController = TextEditingController();
  final _endedAtController = TextEditingController();
  final _ratingController = TextEditingController();
  final _customTypeController = TextEditingController();
  final _customGenreController = TextEditingController();

  File? _selectedImageFile;
  String? _selectedType;
  String? _selectedGenre;
  DateTime? _selectedEndDateTime;

  final List<Map<String, TextEditingController>> _customFieldControllers = [];
  final List<Widget> _additionalFields = [];
  late EventOrganiserNotifier eventNotifier;

  // List of event types and genres
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

  @override
  void dispose() {
    // Dispose all controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _unitPriceController.dispose();
    _capacityController.dispose();
    _placeController.dispose();
    _endedAtController.dispose();
    _ratingController.dispose();
    _customTypeController.dispose();
    _customGenreController.dispose();
    for (var map in _customFieldControllers) {
      map['key']?.dispose();
      map['value']?.dispose();
    }
    super.dispose();
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedEndDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedEndDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedEndDateTime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime.hour, pickedTime.minute);
          _endedAtController.text = _selectedEndDateTime!
              .toLocal()
              .toString()
              .split('.')[0]; // Format as yyyy-MM-dd HH:mm
        });
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedImageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      // Gather custom field values and ensure proper format
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
        'image_file': _selectedImageFile,
        'unit_price': double.tryParse(_unitPriceController.text) ?? 0,
        'capacity': int.tryParse(_capacityController.text) ?? 0,
        'place': _placeController.text,
        'endedAt': _selectedEndDateTime?.toIso8601String() ?? '',
        'rating': double.tryParse(_ratingController.text) ?? 0,
        'type': _selectedType == 'Other'
            ? _customTypeController.text
            : _selectedType,
        'genres': _selectedGenre == 'Other'
            ? _customGenreController.text
            : _selectedGenre,
        'additional_info': customFieldValues.isNotEmpty
            ? jsonEncode(customFieldValues)
            : null, // Ensure proper JSON format
      };

      // Trigger event creation
      final organiserId =
          GetIt.instance.get<OrganiserLocalDataSource>().currentOrganiser!.id!;
      await ref
          .read(eventNotifierProvider.notifier)
          .addEvent(organiserId, eventData, _selectedImageFile!);

      // After successful event creation, clear form
      _formKey.currentState?.reset();
      setState(() {
        _selectedImageFile = null;
        _selectedType = null;
        _selectedGenre = null;
        _selectedEndDateTime = null;
        _additionalFields.clear();
        _customFieldControllers.clear();
      });

      // Show success message and navigate
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Column(
                children: [
                  Text("Congrats!",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text("Your Event is added successfully!",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        AutoRouter.of(context).push(const OrganiserEventRoute());
      }
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      hintText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    );
  }

  void _addNewField() {
    setState(() {
      final keyController = TextEditingController();
      final valueController = TextEditingController();
      _customFieldControllers
          .add({'key': keyController, 'value': valueController});

      _additionalFields.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: keyController,
                  decoration: _buildInputDecoration(
                      'Key ${_customFieldControllers.length}', Icons.key),
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
                      'Value ${_customFieldControllers.length}', Icons.edit),
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
                onImageSelected: (imageFile) =>
                    setState(() => _selectedImageFile = imageFile)),
            const SizedBox(height: 10),
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
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a title'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: _buildInputDecoration(
                            'Description', Icons.description),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a description'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _unitPriceController,
                        keyboardType: TextInputType.number,
                        decoration: _buildInputDecoration(
                            'Unit Price', Icons.attach_money),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a unit price'
                            : double.tryParse(value!) == null
                                ? 'Please enter a valid number'
                                : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _capacityController,
                        keyboardType: TextInputType.number,
                        decoration:
                            _buildInputDecoration('Capacity', Icons.people),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a capacity'
                            : int.tryParse(value!) == null
                                ? 'Please enter a valid number'
                                : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _placeController,
                        decoration: _buildInputDecoration('Place', Icons.place),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a place'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _endedAtController,
                        readOnly: true,
                        decoration: _buildInputDecoration(
                            'End Date & Time', Icons.calendar_today),
                        onTap: () => _selectEndDateTime(context),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select an end date and time'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration:
                            _buildInputDecoration('Type', Icons.category),
                        value: _selectedType,
                        items: _eventTypes
                            .map((String type) => DropdownMenuItem<String>(
                                value: type, child: Text(type)))
                            .toList(),
                        onChanged: (String? newValue) =>
                            setState(() => _selectedType = newValue),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select a type'
                            : null,
                      ),
                      if (_selectedType == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextFormField(
                            controller: _customTypeController,
                            decoration: _buildInputDecoration(
                                'Enter custom type', Icons.category),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter a custom type'
                                : null,
                          ),
                        ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: _buildInputDecoration(
                            'Genre', Icons.gesture_rounded),
                        value: _selectedGenre,
                        items: _eventGenres
                            .map((String genre) => DropdownMenuItem<String>(
                                value: genre, child: Text(genre)))
                            .toList(),
                        onChanged: (String? newValue) =>
                            setState(() => _selectedGenre = newValue),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please select a genre'
                            : null,
                      ),
                      if (_selectedGenre == 'Other')
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextFormField(
                            controller: _customGenreController,
                            decoration: _buildInputDecoration(
                                'Enter custom genre', Icons.gesture_rounded),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter a custom genre'
                                : null,
                          ),
                        ),
                      const SizedBox(height: 16),
                      ..._additionalFields,
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addNewField,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          backgroundColor: Colors.indigo,
                        ),
                        child: const Text("Add Custom Field",
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          backgroundColor: Colors.indigo,
                        ),
                        child: const Text("Add Event",
                            style: TextStyle(color: Colors.white)),
                      ),
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
