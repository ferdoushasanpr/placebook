import 'package:flutter/material.dart';
import 'package:placebook/models/place.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.all(16),
        child: Image.file(
          place.image,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
