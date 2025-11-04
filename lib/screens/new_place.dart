import 'package:flutter/material.dart';
import 'package:placebook/models/place.dart';

class NewPlace extends StatefulWidget {
  const NewPlace({super.key, required this.addPlace});

  final void Function(Place place) addPlace;

  @override
  State<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();

    void savePlace() {
      final enteredTitle = titleController.text.trim();

      if (enteredTitle.isEmpty) return;

      widget.addPlace(Place(title: enteredTitle));
      Navigator.of(context).pop();
    }

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
