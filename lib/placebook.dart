import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placebook/providers/user_places.dart';

import 'package:placebook/screens/new_place.dart';
import 'package:placebook/screens/place_details.dart';

class Placebook extends ConsumerStatefulWidget {
  const Placebook({super.key});

  @override
  ConsumerState<Placebook> createState() => _PlacebookState();
}

class _PlacebookState extends ConsumerState<Placebook> {
  @override
  Widget build(BuildContext context) {
    final places = ref.watch(userPlaceProvider);
    Widget content = Center(child: Text("No Place to Show..."));

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(places[index].image),
            ),
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
                    return NewPlace();
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
