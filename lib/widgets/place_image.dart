import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlaceImage extends StatefulWidget {
  const PlaceImage({super.key, required this.pickImage});

  final void Function(File image) pickImage;

  @override
  State<PlaceImage> createState() => _PlaceImageState();
}

class _PlaceImageState extends State<PlaceImage> {
  File? _storedImage;

  void _selectImage() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
    );

    if (pickedImage == null) return;

    widget.pickImage(File(pickedImage.path));
    setState(() {
      _storedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _selectImage,
      label: Text("Add Image"),
      icon: Icon(Icons.add),
    );

    if (_storedImage != null) {
      content = Image.file(
        _storedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        height: 250,
        width: double.infinity,
        child: content,
      ),
    );
  }
}
