import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placebook/models/place.dart';
import 'package:placebook/screens/full_map.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FullMap(place: place);
                        },
                      ),
                    );
                  },
                  child: AbsorbPointer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              place.location.latitude,
                              place.location.longitude,
                            ),
                            initialZoom: 13.0,
                            interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.none,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                              subdomains: const ['a', 'b', 'c', 'd'],
                              userAgentPackageName: 'com.example.app',
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
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        place.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "Latiture: ${place.location.latitude}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "Longitute: ${place.location.longitude}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
