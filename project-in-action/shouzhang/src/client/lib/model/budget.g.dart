// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetAdapter extends TypeAdapter<Budget> {
  @override
  final int typeId = 1;

  @override
  Budget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Budget()
      ..id = fields[0] as String
      ..user = fields[1] as String?
      ..year = fields[2] as String?
      ..reason = fields[3] as String
      ..type = fields[4] as int
      ..amount = fields[5] as double
      ..note = fields[6] as String
      ..updateTime = fields[7] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Budget obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.year)
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
      other is BudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
