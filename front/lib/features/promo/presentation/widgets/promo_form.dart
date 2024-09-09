import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/promo/presentation/blocs/add_promo_provider.dart';
import 'package:front/features/promo/presentation/blocs/state/add_promo_state/add_promo_state.dart';
import 'package:intl/intl.dart';

class PromoFormModal extends ConsumerStatefulWidget {
  final String idevent;

  const PromoFormModal({required this.idevent, Key? key}) : super(key: key);

  @override
  _PromoFormModalState createState() => _PromoFormModalState();
}

class _PromoFormModalState extends ConsumerState<PromoFormModal> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ticketNumberController = TextEditingController();
  final TextEditingController _percentageEventController =
      TextEditingController();
  final TextEditingController _percentageParkingController =
      TextEditingController();
  final TextEditingController _endedAtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Listen to state changes in addpromoNotifierProvider
    ref.listen<AddPromoState>(addpromoNotifierProvider, (previous, next) {
      if (next is Success) {
        // Show success message
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
                  Text("Your Promo is added successfully!",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        Navigator.of(context).pop(); // Close the modal
      } else if (next is Error) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("next.message")),
        );
      }
    });

    InputDecoration _buildInputDecoration(String labelText, IconData icon) {
      return InputDecoration(
        labelText: labelText,
        hintText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text('Add Promo'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
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
              const SizedBox(height: 10),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration:
                    _buildInputDecoration('Description', Icons.description),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: _buildInputDecoration('Address', Icons.location_on),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Ticket Number
              TextFormField(
                controller: _ticketNumberController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(
                    'Ticket Number', Icons.confirmation_number),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ticket number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Event Discount Percentage
              TextFormField(
                controller: _percentageEventController,
                keyboardType: TextInputType.number,
                decoration:
                    _buildInputDecoration('Event Discount %', Icons.percent),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a percentage for the event discount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid percentage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Parking Discount Percentage
              TextFormField(
                controller: _percentageParkingController,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(
                    'Parking Discount %', Icons.local_parking),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a percentage for parking discount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid percentage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // End Date
              TextFormField(
                controller: _endedAtController,
                readOnly: true,
                decoration:
                    _buildInputDecoration('End Date', Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _endedAtController.text = formattedDate;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Collect the form data
              final promoData = {
                "title": _titleController.text,
                "description": _descriptionController.text,
                "address": _addressController.text,
                "ticketNumber": int.parse(_ticketNumberController.text),
                "percentageEvent":
                    double.parse(_percentageEventController.text),
                "percentageParking":
                    double.parse(_percentageParkingController.text),
                "endedAt": _endedAtController
                    .text, // You can further format this if needed
              };

              // Call the promoNotifier to handle promo submission
              ref
                  .read(addpromoNotifierProvider.notifier)
                  .addPromo(widget.idevent, promoData);
            }
          },
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
