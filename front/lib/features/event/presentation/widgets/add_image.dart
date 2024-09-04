import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddImageWidget extends ConsumerStatefulWidget {
  final Function(File?) onImageSelected;
  final bool isRequired;

  const AddImageWidget(
      {Key? key, required this.onImageSelected, this.isRequired = false})
      : super(key: key);

  @override
  _AddImageWidgetState createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends ConsumerState<AddImageWidget> {
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: source);
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
        });
        widget.onImageSelected(_imageFile);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_imageFile != null)
          SizedBox(
            width: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(_imageFile!),
            ),
          )
        else
          Container(
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: widget.isRequired
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.transparent),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: "",
                placeholder: (context, url) =>
                    Image.asset('assets/placeholder.webp'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/event.png'),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await pickImage(ImageSource.gallery);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 254, 252, 252),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
