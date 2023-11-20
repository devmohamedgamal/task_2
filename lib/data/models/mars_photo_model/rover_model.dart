import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rover_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(createToJson: false)
class RoverModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  @JsonKey(name: 'landing_date',fromJson: _dateFromString)
  final DateTime landingDate;
  @HiveField(3)
  @JsonKey(name: 'launch_date',fromJson: _dateFromString)
  final DateTime launchDate;
  @HiveField(4)
  final String status;
  @HiveField(5)
  @JsonKey(name: 'max_sol')
  final int maxSol;
  @HiveField(6)
  @JsonKey(name: 'max_date',fromJson: _dateFromString)
  final DateTime maxDate;
  @HiveField(7)
  @JsonKey(name: 'total_photos')
  final int totalPhotos;
  @HiveField(8)

  final List<Cameras> cameras;
  RoverModel({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.cameras,
  });

  static DateTime _dateFromString(String date) => DateTime.parse(date);
  factory RoverModel.fromLson(Map<String, dynamic> json) =>
      _$RoverModelFromJson(json);
}

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class Cameras {
  @HiveField(0)
  final String name;
  @HiveField(1)
  @JsonKey(name: 'full_name')
  final String fullName;

  Cameras({
    required this.name,
    required this.fullName,
  });

  factory Cameras.fromLson(Map<String, dynamic> json) =>
      _$CamerasFromJson(json);
}
