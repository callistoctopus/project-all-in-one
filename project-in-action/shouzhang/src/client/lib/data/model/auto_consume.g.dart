// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_consume.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutoConsumeAdapter extends TypeAdapter<AutoConsume> {
  @override
  final int typeId = 8;

  @override
  AutoConsume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AutoConsume(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as int,
      fields[5] as double,
      fields[7] as DateTime,
    )..isDeleted = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, AutoConsume obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.reason)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.amount)
      ..writeByte(6)
      ..write(obj.isDeleted)
      ..writeByte(7)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoConsumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoConsume _$AutoConsumeFromJson(Map<String, dynamic> json) => AutoConsume(
      json['id'] as String,
      json['user'] as String,
      json['duration'] as int,
      json['reason'] as String,
      json['type'] as int,
      (json['amount'] as num).toDouble(),
      DateTime.parse(json['updateTime'] as String),
    )..isDeleted = json['isDeleted'] as int;

Map<String, dynamic> _$AutoConsumeToJson(AutoConsume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'duration': instance.duration,
      'reason': instance.reason,
      'type': instance.type,
      'amount': instance.amount,
      'isDeleted': instance.isDeleted,
      'updateTime': instance.updateTime.toIso8601String(),
    };
