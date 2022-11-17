/*
 * @Author: gui-qi
 * @Date: 2022-11-09 10:00:06
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-17 01:28:58
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// GENERATED CODE - DO NOT MODIFY BY HAND

part of './account_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountUserAdapter extends TypeAdapter<AccountUser> {
  @override
  final int typeId = 3;

  @override
  AccountUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountUser(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AccountUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.account)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.isDeleted)
      ..writeByte(5)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountUser _$AccountUserFromJson(Map<String, dynamic> json) => AccountUser(
      json['id'] as String,
      json['user'] as String,
      json['account'] as String,
      json['state'] as int,
      json['isDeleted'] as int,
      DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$AccountUserToJson(AccountUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'account': instance.account,
      'state': instance.state,
      'isDeleted': instance.isDeleted,
      'updateTime': instance.updateTime.toIso8601String(),
    };
