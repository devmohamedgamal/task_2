import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_2/data/models/mars_photo_model/rover_model.dart';
import 'package:task_2/data/repos/mars_photos_repo.dart';

import '../../../data/models/mars_photo_model/mars_photo_model.dart';

part 'mars_photos_state.dart';

class MarsPhotosCubit extends Cubit<MarsPhotosState> {
  MarsPhotosCubit(this.marsPhotosRepo) : super(MarsPhotosInitial()) {
    fetchLatestMarsPhotos();
  }
  final MarsPhotosRepo marsPhotosRepo;
  final ScrollController scrollController = ScrollController();

  List<MarsPhotoModel> photos = [];
  int pageCount = 1;
  bool isPhotosLoaded = false;

  void clearPhotoList() {
    photos.clear();
    pageCount = 1;
    isPhotosLoaded = false;
  }

  void checkScrollPosition(DateTime? earthDate) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (earthDate != null) {
        fetchDateMarsPhotos(date: earthDate, page: pageCount++);
        log(pageCount.toString());
      }
      log("End Of The List");
    }
  }

  Future<void> fetchLatestMarsPhotos() async {
    emit(MarsPhotosLoading());
    var result = await marsPhotosRepo.feetchLatestMarsPhotos();
    result.fold((failure) {
      emit(MarsPhotosFailure(errMessage: failure.errorMessage));
    }, (success) {
      photos.addAll(success);
      emit(MarsPhotosSuccess(photos: photos));
    });
  }

  Future<void> fetchDateMarsPhotos({required DateTime date, int? page}) async {
    emit(MarsPhotosLoading());

    var result = await marsPhotosRepo.fetchDateMarsPhotos(
        date: date, page: page ?? pageCount);
    result.fold((failure) {
      emit(MarsPhotosFailure(errMessage: failure.errorMessage));
    }, (success) {
      photos.addAll(success);
      isPhotosLoaded = true;
      emit(MarsPhotosSuccess(photos: photos));
    });
  }
}
