// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserObjectAdapter extends TypeAdapter<UserObject> {
  @override
  final int typeId = 0;

  @override
  UserObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserObject(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as UserStatusObject,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.avatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserStatusObjectAdapter extends TypeAdapter<UserStatusObject> {
  @override
  final int typeId = 1;

  @override
  UserStatusObject read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserStatusObject.worker;
      case 1:
        return UserStatusObject.manager;
      default:
        return UserStatusObject.worker;
    }
  }

  @override
  void write(BinaryWriter writer, UserStatusObject obj) {
    switch (obj) {
      case UserStatusObject.worker:
        writer.writeByte(0);
        break;
      case UserStatusObject.manager:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
