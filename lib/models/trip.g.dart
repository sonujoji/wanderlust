// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 1;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      id: fields[6] as int?,
      title: fields[0] as String,
      description: fields[1] as String,
      budget: fields[2] as int,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      travellorCount: fields[5] as int,
      country: fields[7] as String?,
      destinationImage: fields[8] as String,
      travellors: (fields[9] as List?)?.cast<String>(),
      isFavorite: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.budget)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.travellorCount)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.country)
      ..writeByte(8)
      ..write(obj.destinationImage)
      ..writeByte(9)
      ..write(obj.travellors)
      ..writeByte(10)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
