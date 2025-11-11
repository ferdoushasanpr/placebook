import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:placebook/models/place.dart';

class FullMap extends StatefulWidget {
  const FullMap({
    super.key,
    this.place,
    this.isSelecting = false,
    this.onSelectLocation,
  });

  final Place? place;
  final bool isSelecting;
  final void Function(double lat, double lng)? onSelectLocation;

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.place != null && !widget.isSelecting) {
      _pickedLocation = LatLng(
        widget.place!.location.latitude,
        widget.place!.location.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.place != null ? widget.place!.title : 'Map'} Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                widget.onSelectLocation!(
                  _pickedLocation!.latitude,
                  _pickedLocation!.longitude,
                );
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: (_, tappedPoint) {
            if (widget.isSelecting) {
              setState(() {
                _pickedLocation = tappedPoint;
              });
            } else {
              return;
            }
          },
          initialCenter: LatLng(
            _pickedLocation?.latitude ?? 23.8103,
            _pickedLocation?.longitude ?? 90.4125,
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
                  (_pickedLocation != null)
                      ? _pickedLocation!.latitude
                      : 23.8103,
                  (_pickedLocation != null)
                      ? _pickedLocation!.longitude
                      : 90.4125,
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
