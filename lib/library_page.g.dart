// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibStoreAdapter extends TypeAdapter<LibStore> {
  @override
  final int typeId = 0;

  @override
  LibStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibStore(
      title: fields[0] as String,
      coverBytes: fields[1] as Uint8List,
      filepath: fields[2] as String,
      author: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LibStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.coverBytes)
      ..writeByte(2)
      ..write(obj.filepath)
      ..writeByte(3)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
