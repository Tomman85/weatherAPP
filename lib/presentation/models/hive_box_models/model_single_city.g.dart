// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_single_city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataSingleModelAdapter extends TypeAdapter<DataSingleModel> {
  @override
  final int typeId = 1;

  @override
  DataSingleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataSingleModel(
      latitude: fields[0] as String,
      longitude: fields[1] as String,
      cityName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataSingleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSingleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
