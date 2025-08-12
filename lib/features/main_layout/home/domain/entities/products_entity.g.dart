// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsEntityAdapter extends TypeAdapter<ProductsEntity> {
  @override
  final int typeId = 1;

  @override
  ProductsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsEntity(
      id: fields[0] as String,
      image: fields[1] as String,
      title: fields[2] as String,
      price: fields[3] as int,
      rating: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductsEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
