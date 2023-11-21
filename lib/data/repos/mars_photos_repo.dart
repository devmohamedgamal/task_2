import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:task_2/data/api/api_service.dart';
import 'package:task_2/data/db/db_function.dart';
import 'package:task_2/data/models/mars_photo_model/mars_photo_model.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/utils/app_constants.dart';

class MarsPhotosRepo {
  late ApiService apiService;

  MarsPhotosRepo() {
    apiService = ApiService();
  }

  Future<List<MarsPhotoModel>> fetchLatestPhotos() async {
    final data = await apiService.fetchLatestPhotos();
    final photos =
        data.map((photoMap) => MarsPhotoModel.fromLson(photoMap)).toList();
    saveMarsPhoto(photos: photos);

    return photos;
  }

  Future<List<MarsPhotoModel>> fetchDatePhotos(
      {required DateTime earthDate}) async {
    // bool online = await InternetConnectionChecker().hasConnection;
    // if (online == true) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(earthDate);
      log(formattedDate);
      final data = await apiService.fetchDatePhotos(earthDate: formattedDate);
      final photos =
          data.map((photoMap) => MarsPhotoModel.fromLson(photoMap)).toList();
      log(photos.first.imgSrc);
      debugPrint(photos.length.toString());
      saveMarsPhoto(photos: photos);
      return photos;
    // } else {
    //   return fetchLocalDatePhoto(earthDate);
    // }
  }

  Future<bool> fetchRoverDetails() async {
    try {
      final data = await apiService.fetchRoverDetails();
      RoverModel rover = RoverModel.fromLson(data);
      debugPrint(rover.maxDate.toString());
      Hive.box<RoverModel>(AppConstants.kRoverKey)
          .put(AppConstants.kRoverDetails, rover);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
