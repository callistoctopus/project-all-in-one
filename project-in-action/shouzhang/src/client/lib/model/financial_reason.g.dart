// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_reason.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinancialReasonAdapter extends TypeAdapter<FinancialReason> {
  @override
  final int typeId = 0;

  @override
  FinancialReason read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinancialReason()
      ..id = fields[0] as String?
      ..user = fields[1] as String
      ..reason = fields[2] as String?
      ..type = fields[3] as int
      ..note = fields[4] as String?
      ..updateTime = fields[5] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, FinancialReason obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.reason)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialReasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
