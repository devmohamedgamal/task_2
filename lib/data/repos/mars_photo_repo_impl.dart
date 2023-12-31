import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:task_2/data/models/mars_photo_model/mars_photo_model.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/data/repos/mars_photos_repo.dart';
import 'package:task_2/utils/errors/failure.dart';

import '../../utils/app_constants.dart';
import '../api/api_service.dart';
import '../db/db_function.dart';

class MarsPhotosRepoImpl implements MarsPhotosRepo {
  late ApiService apiService;

  MarsPhotosRepoImpl() {
    apiService = ApiService();
  }

  @override
  Future<Either<Failure, List<MarsPhotoModel>>> feetchLatestMarsPhotos() async {
    try {
      final data = await apiService.fetchLatestPhotos();
      final photos =
          data.map((photoMap) => MarsPhotoModel.fromLson(photoMap)).toList();
      saveMarsPhoto(photos: photos);

      return right(photos);
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MarsPhotoModel>>> fetchDateMarsPhotos(
      {required DateTime date,int? page}) async {
    // bool online = await InternetConnectionChecker().hasConnection;
    // if (online == true) {
    final formattedDate = DateFormat("yyyy-MM-dd").format(date);
    log(formattedDate);
    final data = await apiService.fetchDatePhotos(earthDate: formattedDate,page: page ?? 1);
    final photos =
        data.map((photoMap) => MarsPhotoModel.fromLson(photoMap)).toList();
    debugPrint(photos.length.toString());
    saveMarsPhoto(photos: photos);
    return right(photos);
    // } else {
    //   return fetchLocalDatePhoto(formattedDate);
    // }
  }

  @override
  Future<Either<Failure, RoverModel>> fetchRoverDetails() async {
    try {
      final data = await apiService.fetchRoverDetails();
      RoverModel rover = RoverModel.fromLson(data);
      debugPrint(rover.maxDate.toString());
      Hive.box<RoverModel>(AppConstants.kRoverKey)
          .put(AppConstants.kRoverDetails, rover);
      return right(rover);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
