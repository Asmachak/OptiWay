import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class DropdownMenu extends ConsumerStatefulWidget {
  final List<String> items;
  final String title;

  DropdownMenu({Key? key, required this.items, required this.title})
      : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends ConsumerState<DropdownMenu> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white10,
            side: const BorderSide(
              color: Colors.indigo,
              width: 2.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select Item'),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      width: double.maxFinite, // Expand to max width
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(widget.items[index]),
                            onTap: () {
                              setState(() {
                                _selectedItem = widget.items[index];
                              });
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedItem ?? widget.title,
                style: const TextStyle(color: Colors.indigo),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ],
          ),
        ),
        if (_selectedItem != null) ...[
          const SizedBox(height: 16),
          Text('Selected Item: $_selectedItem'),
        ],
      ],
    );
  }
}
