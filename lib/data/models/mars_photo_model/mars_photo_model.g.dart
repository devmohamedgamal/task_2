// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mars_photo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarsPhotoModelAdapter extends TypeAdapter<MarsPhotoModel> {
  @override
  final int typeId = 0;

  @override
  MarsPhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarsPhotoModel(
      id: fields[0] as int,
      sol: fields[1] as int,
      camera: fields[2] as Camera,
      imgSrc: fields[3] as String,
      earthDate: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MarsPhotoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sol)
      ..writeByte(2)
      ..write(obj.camera)
      ..writeByte(3)
      ..write(obj.imgSrc)
      ..writeByte(4)
      ..write(obj.earthDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarsPhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CameraAdapter extends TypeAdapter<Camera> {
  @override
  final int typeId = 1;

  @override
  Camera read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Camera(
      id: fields[0] as int,
      name: fields[1] as String,
      roverId: fields[2] as int,
      fullName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Camera obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.roverId)
      ..writeByte(3)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
