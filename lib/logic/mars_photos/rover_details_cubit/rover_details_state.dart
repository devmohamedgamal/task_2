part of 'rover_details_cubit.dart';

sealed class RoverDetailsState extends Equatable {
  const RoverDetailsState();

  @override
  List<Object> get props => [];
}

final class RoverDetailsInitial extends RoverDetailsState {}



final class RoverDetailsLoading extends RoverDetailsState {}

final class RoverDetailsFailure extends RoverDetailsState {
  final String errMessage;

  const RoverDetailsFailure({required this.errMessage});
}

final class RoverDetailsSuccess extends RoverDetailsState {
  final RoverModel rover;

  const RoverDetailsSuccess({required this.rover});
}
