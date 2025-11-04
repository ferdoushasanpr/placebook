import 'package:flutter/material.dart';
import 'package:placebook/models/place.dart';

import 'package:placebook/screens/new_place.dart';
import 'package:placebook/screens/place_details.dart';

class Placebook extends StatefulWidget {
  const Placebook({super.key});

  @override
  State<Placebook> createState() => _PlacebookState();
}

class _PlacebookState extends State<Placebook> {
  final List<Place> places = [];

  void addPlace(Place place) {
    setState(() {
      places.add(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text("No Place to Show..."));

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PlaceDetails(place: places[index]);
                  },
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("PlaceBook"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NewPlace(addPlace: addPlace);
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
