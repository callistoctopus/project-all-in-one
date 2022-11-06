// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 2;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill()
      ..id = fields[0] as String?
      ..user = fields[1] as String
      ..time = fields[2] as DateTime?
      ..reason = fields[3] as String?
      ..type = fields[4] as int?
      ..amount = fields[5] as double?
      ..note = fields[6] as String?
      ..updateTime = fields[7] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.reason)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
