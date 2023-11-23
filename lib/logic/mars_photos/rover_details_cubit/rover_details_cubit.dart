import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/mars_photo_model/rover_model.dart';
import '../../../data/repos/mars_photos_repo.dart';

part 'rover_details_state.dart';

class RoverDetailsCubit extends Cubit<RoverDetailsState> {
  RoverDetailsCubit(this.marsPhotosRepo) : super(RoverDetailsInitial()) {
    fetchRoverData();
  }

  final MarsPhotosRepo marsPhotosRepo;

  Future<void> fetchRoverData() async {
    emit(RoverDetailsLoading());
    var rover = await marsPhotosRepo.fetchRoverDetails();
    rover.fold((failure) {
      emit(RoverDetailsFailure(errMessage: failure.errorMessage));
    }, (success) {
      emit(RoverDetailsSuccess(rover: success));
    });
  }
}
