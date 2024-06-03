import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/blocs/edit_providers.dart';
import 'package:front/features/user/presentation/blocs/state/edit/edit_state.dart';

File? imageFile;
Uint8List? _imageBytes;
final ImagePicker _imagePicker = ImagePicker();

class ProfilTopWidget extends ConsumerStatefulWidget {
  const ProfilTopWidget({Key? key}) : super(key: key);

  @override
  _ProfilTopWidgetState createState() => _ProfilTopWidgetState();
}

class _ProfilTopWidgetState extends ConsumerState<ProfilTopWidget> {
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: source);
      if (file != null) {
        imageFile = File(file.path);
        final Uint8List imageBytes = await file.readAsBytes();
        setState(() {
          _imageBytes = imageBytes;
        });
      }
    } catch (e) {
      // Handle errors like permission denied or cancelled selection
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final editNotifier = ref.watch(editNotifierProvider.notifier);
    final editState = ref.watch(editNotifierProvider);

    return Stack(
      children: [
        if (_imageBytes != null)
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.memory(_imageBytes!),
            ),
          )
        else
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: GetIt.instance
                        .get<AuthLocalDataSource>()
                        .currentUser
                        ?.photo ??
                    '',
                placeholder: (context, url) => Image.asset(
                    'assets/placeholder.webp'), // Replace with your asset path
                errorWidget: (context, url, error) => Image.asset(
                    'assets/error.png'), // Replace with your fallback asset path
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              await pickImage(ImageSource.gallery);
              if (imageFile != null) {
                await editNotifier.uploadImage(
                  imageFile!,
                  GetIt.instance.get<AuthLocalDataSource>().currentUser!.id!,
                );
                if (editState is Loading) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }
                if (editState is Success) {
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
                            Text(
                              "Congrats!",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              " Your Profile Photo is updated successfully!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                }
              }
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.indigo.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
