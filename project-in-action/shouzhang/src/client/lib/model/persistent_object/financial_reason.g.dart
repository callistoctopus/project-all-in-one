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
    return FinancialReason(
      fields[0] as String?,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as int,
      fields[4] as String?,
      fields[5] as int,
      fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FinancialReason obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.isDeleted)
      ..writeByte(6)
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialReason _$FinancialReasonFromJson(Map<String, dynamic> json) =>
    FinancialReason(
      json['id'] as String?,
      json['user'] as String,
      json['reason'] as String?,
      json['type'] as int,
      json['note'] as String?,
      json['isDeleted'] as int,
      json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$FinancialReasonToJson(FinancialReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'reason': instance.reason,
      'type': instance.type,
      'note': instance.note,
      'isDeleted': instance.isDeleted,
      'updateTime': instance.updateTime?.toIso8601String(),
    };
