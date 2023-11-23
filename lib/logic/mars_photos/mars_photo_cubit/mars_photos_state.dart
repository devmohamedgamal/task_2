part of 'mars_photos_cubit.dart';

sealed class MarsPhotosState extends Equatable {
  const MarsPhotosState();

  @override
  List<Object> get props => [];
}

final class MarsPhotosInitial extends MarsPhotosState {}

final class MarsPhotosLoading extends MarsPhotosState {}

final class MarsPhotosFailure extends MarsPhotosState {
  final String errMessage;

  const MarsPhotosFailure({required this.errMessage});
}

final class MarsPhotosSuccess extends MarsPhotosState {
  final List<MarsPhotoModel> photos;

  const MarsPhotosSuccess({required this.photos});
}
