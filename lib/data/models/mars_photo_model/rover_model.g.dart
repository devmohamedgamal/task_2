// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rover_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoverModelAdapter extends TypeAdapter<RoverModel> {
  @override
  final int typeId = 2;

  @override
  RoverModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoverModel(
      id: fields[0] as int,
      name: fields[1] as String,
      landingDate: fields[2] as DateTime,
      launchDate: fields[3] as DateTime,
      status: fields[4] as String,
      maxSol: fields[5] as int,
      maxDate: fields[6] as DateTime,
      totalPhotos: fields[7] as int,
      cameras: (fields[8] as List).cast<Cameras>(),
    );
  }

  @override
  void write(BinaryWriter writer, RoverModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.landingDate)
      ..writeByte(3)
      ..write(obj.launchDate)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.maxSol)
      ..writeByte(6)
      ..write(obj.maxDate)
      ..writeByte(7)
      ..write(obj.totalPhotos)
      ..writeByte(8)
      ..write(obj.cameras);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoverModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CamerasAdapter extends TypeAdapter<Cameras> {
  @override
  final int typeId = 3;

  @override
  Cameras read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cameras(
      name: fields[0] as String,
      fullName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Cameras obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CamerasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoverModel _$RoverModelFromJson(Map<String, dynamic> json) => RoverModel(
      id: json['id'] as int,
      name: json['name'] as String,
      landingDate: json['landing_date'] as DateTime,
      launchDate: json['launch_date'] as DateTime,
      status: json['status'] as String,
      maxSol: json['max_sol'] as int,
      maxDate: json['max_date'] as DateTime,
      totalPhotos: json['total_photos'] as int,
      cameras: (json['cameras'] as List<dynamic>)
          .map((e) => Cameras.fromLson(e as Map<String, dynamic>))
          .toList(),
    );

Cameras _$CamerasFromJson(Map<String, dynamic> json) => Cameras(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
    );
