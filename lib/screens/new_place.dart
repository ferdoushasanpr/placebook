import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placebook/providers/user_places.dart';
import 'package:placebook/widgets/place_image.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final titleController = TextEditingController();
  File? selectedImage;

  void selectImage(File image) {
    selectedImage = image;
  }

  void savePlace() {
    final enteredTitle = titleController.text.trim();

    if (enteredTitle.isEmpty || selectedImage == null) return;

    ref.read(userPlaceProvider.notifier).addPlace(enteredTitle, selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Place")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(label: Text("Title")),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(height: 16),
            PlaceImage(pickImage: selectImage),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                savePlace();
              },
              icon: Icon(Icons.add),
              label: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
