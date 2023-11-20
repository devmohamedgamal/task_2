import 'package:hive_flutter/adapters.dart';
import 'package:task_2/data/models/mars_photo_model/mars_photo_model.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';

import '../../utils/app_constants.dart';

Future<void> initDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MarsPhotoModelAdapter());
  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(RoverModelAdapter());
  Hive.registerAdapter(CamerasAdapter());
  await Hive.openBox(AppConstants.ksettingsKey);
  await Hive.openBox<MarsPhotoModel>(AppConstants.kMarsPhotoKey);
  await Hive.openBox<RoverModel>(AppConstants.kRoverKey);
}
