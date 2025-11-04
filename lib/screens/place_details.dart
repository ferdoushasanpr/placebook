import 'package:flutter/material.dart';
import 'package:placebook/models/place.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Center(child: Text("Details of the ${place.title}")),
    );
  }
}
