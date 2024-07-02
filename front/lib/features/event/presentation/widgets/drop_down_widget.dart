import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State providers for type, parking, and rating
final typeProvider = StateProvider<String>((ref) => '');
final parkingProvider = StateProvider<String>((ref) => '');
final ratingProvider = StateProvider<String>((ref) => '');

class DropdownMenu extends ConsumerStatefulWidget {
  final List<String> items;
  final String title;
  final StateProvider<String> provider;

  DropdownMenu({
    Key? key,
    required this.items,
    required this.title,
    required this.provider,
  }) : super(key: key);

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends ConsumerState<DropdownMenu> {
  String? _selectedItem;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedItem = ref.read(widget.provider).isEmpty
        ? widget.title
        : ref.read(widget.provider);
  }

  @override
  Widget build(BuildContext context) {
    _selectedItem = ref.watch(widget.provider).isEmpty
        ? widget.title
        : ref.watch(widget.provider);

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
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    var filteredItems = widget.items
                        .where((item) => item
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    return AlertDialog(
                      title: const Text('Select Item'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 138, 151, 216)
                                      .withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor:
                                  const Color.fromARGB(255, 45, 56, 116),
                            ),
                            onChanged: (query) {
                              setState(() {
                                _searchQuery = query;
                              });
                            },
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: filteredItems.length > 5
                                ? 300.0 // Set a max height for scrollable items
                                : filteredItems.length *
                                    56.0, // Adjust height based on items
                            child: Scrollbar(
                              thumbVisibility:
                                  true, // Ensure scrollbar is always visible
                              child: ListView.builder(
                                itemCount: filteredItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(filteredItems[index]),
                                    onTap: () {
                                      setState(() {
                                        _selectedItem = filteredItems[index];
                                      });
                                      ref.read(widget.provider.notifier).state =
                                          filteredItems[index];
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedItem = widget.title;
                            });
                            ref.read(widget.provider.notifier).state = '';
                            Navigator.of(context).pop();
                          },
                          child: const Text('Clear Selection'),
                        ),
                      ],
                    );
                  },
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
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
