// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_create_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AutoCreateConfigAdapter extends TypeAdapter<AutoCreateConfig> {
  @override
  final int typeId = 5;

  @override
  AutoCreateConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AutoCreateConfig(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as int,
      fields[6] as double,
      fields[7] as String,
      fields[8] as int,
      fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AutoCreateConfig obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.budget)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.isDeleted)
      ..writeByte(9)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoCreateConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoCreateConfig _$AutoCreateConfigFromJson(Map<String, dynamic> json) =>
    AutoCreateConfig(
      json['id'] as String,
      json['user'] as String,
      json['year'] as String,
      json['reason'] as String,
      json['type'] as int,
      json['duration'] as int,
      (json['budget'] as num).toDouble(),
      json['note'] as String,
      json['isDeleted'] as int,
      DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$AutoCreateConfigToJson(AutoCreateConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'year': instance.year,
      'reason': instance.reason,
      'type': instance.type,
      'duration': instance.duration,
      'budget': instance.budget,
      'note': instance.note,
      'isDeleted': instance.isDeleted,
      'updateTime': instance.updateTime.toIso8601String(),
    };
