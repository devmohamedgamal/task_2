import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/data/repos/mars_photos_repo.dart';

import '../../../data/models/mars_photo_model/mars_photo_model.dart';

part 'mars_photos_state.dart';

class MarsPhotosCubit extends Cubit<MarsPhotosState> {
  MarsPhotosCubit(this.marsPhotosRepo) : super(MarsPhotosInitial()) {
    fetchLatestMarsPhotos();
  }
  final MarsPhotosRepo marsPhotosRepo;

  Future<void> fetchLatestMarsPhotos() async {
    emit(MarsPhotosLoading());
    var result = await marsPhotosRepo.feetchLatestMarsPhotos();
    result.fold((failure) {
      emit(MarsPhotosFailure(errMessage: failure.errorMessage));
    }, (success) {
      emit(MarsPhotosSuccess(photos: success));
    });
  }

  Future<void> fetchDateMarsPhotos({required DateTime date}) async {
    emit(MarsPhotosLoading());
    var result = await marsPhotosRepo.fetchDateMarsPhotos(date: date);
    result.fold((failure) {
      emit(MarsPhotosFailure(errMessage: failure.errorMessage));
    }, (success) {
      emit(MarsPhotosSuccess(photos: success));
    });
  }
}
