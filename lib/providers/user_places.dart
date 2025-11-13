import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as p;

import 'package:placebook/models/place.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final imagePath = p.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$imagePath');

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>(
  (ref) {
    return UserPlaceNotifier();
  },
);
