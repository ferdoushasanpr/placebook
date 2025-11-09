import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placebook/models/place.dart';

class FullMap extends StatelessWidget {
  const FullMap({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${place.title} Location')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            place.location.latitude,
            place.location.longitude,
          ),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  place.location.latitude,
                  place.location.longitude,
                ),
                width: 80.0,
                height: 80.0,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
