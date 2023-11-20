import 'package:hive_flutter/adapters.dart';

import '../../utils/app_constants.dart';
import '../models/mars_photo_model/mars_photo_model.dart';

Box<MarsPhotoModel> marsPhotosBox =
    Hive.box<MarsPhotoModel>(AppConstants.kMarsPhotoKey);

void saveMarsPhoto({required List<MarsPhotoModel> photos}) {
  for (MarsPhotoModel photo in photos) {
    final MarsPhotoModel? localPhoto = marsPhotosBox.get(photo.id);
    if (localPhoto != photo) {
      marsPhotosBox.put(photo.id, photo);
    }
  }
}

List<MarsPhotoModel> fetchLocalDatePhoto(DateTime earthDate) {
  return Hive.box<MarsPhotoModel>(AppConstants.kMarsPhotoKey)
      .values
      .where((MarsPhotoModel photo) => photo.earthDate == earthDate)
      .toList();
}
