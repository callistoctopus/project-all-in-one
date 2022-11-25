// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetAdapter extends TypeAdapter<Target> {
  @override
  final int typeId = 6;

  @override
  Target read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Target(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String,
      fields[4] as int,
      fields[5] as double,
      fields[6] as String,
      fields[8] as DateTime,
    )..isDeleted = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, Target obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.isDeleted)
      ..writeByte(8)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Target _$TargetFromJson(Map<String, dynamic> json) => Target(
      json['id'] as String,
      json['user'] as String,
      DateTime.parse(json['time'] as String),
      json['reason'] as String,
      json['type'] as int,
      (json['amount'] as num).toDouble(),
      json['note'] as String,
      DateTime.parse(json['updateTime'] as String),
    )..isDeleted = json['isDeleted'] as int;

Map<String, dynamic> _$TargetToJson(Target instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'time': instance.time.toIso8601String(),
      'reason': instance.reason,
      'type': instance.type,
      'amount': instance.amount,
      'note': instance.note,
      'isDeleted': instance.isDeleted,
      'updateTime': instance.updateTime.toIso8601String(),
    };
