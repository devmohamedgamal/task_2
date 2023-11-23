import 'package:dartz/dartz.dart';
import 'package:task_2/data/models/mars_photo_model/mars_photo_model.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/utils/errors/failure.dart';

abstract class MarsPhotosRepo {
  Future<Either<Failure, RoverModel>> fetchRoverDetails();
  Future<Either<Failure, List<MarsPhotoModel>>> fetchDateMarsPhotos(
      {required DateTime date});
  Future<Either<Failure, List<MarsPhotoModel>>> feetchLatestMarsPhotos();
}
