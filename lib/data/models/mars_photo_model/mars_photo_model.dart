import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'mars_photo_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(createToJson: false)
class MarsPhotoModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  int sol;
  @HiveField(2)
  @JsonKey(fromJson: Camera.fromLson)
  Camera camera;
  @HiveField(3)
  @JsonKey(name: "img_src")
  String imgSrc;
  @HiveField(4)
  @JsonKey(name: "earth_date", fromJson: _dateFromString)
  String earthDate;

  MarsPhotoModel({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
  });
  static DateTime _dateFromString(String date) => DateTime.parse(date);
  factory MarsPhotoModel.fromLson(Map<String, dynamic> json) => _$MarsPhotoModelFromJson(json);

}

@HiveType(typeId: 1)
@JsonSerializable(createToJson: false)
class Camera {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  @JsonKey(name: "rover_id")
  int roverId;
  @HiveField(3)
  @JsonKey(name: "full_name")
  String fullName;

  Camera({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  factory Camera.fromLson(Map<String, dynamic> json) => _$CameraFromJson(json);
}
