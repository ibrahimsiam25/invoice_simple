// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceModelAdapter extends TypeAdapter<InvoiceModel> {
  @override
  final int typeId = 3;

  @override
  InvoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceModel(
      issuedDate: fields[0] as DateTime,
      invoiceNumber: fields[1] as String,
      businessAccount: fields[2] as BusinessUserModel,
      client: fields[3] as ClientModel,
      items: (fields[4] as List).cast<ItemModel>(),
      total: fields[5] as double,
      currency: fields[6] as String,
      imagePath: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.issuedDate)
      ..writeByte(1)
      ..write(obj.invoiceNumber)
      ..writeByte(2)
      ..write(obj.businessAccount)
      ..writeByte(3)
      ..write(obj.client)
      ..writeByte(4)
      ..write(obj.items)
      ..writeByte(5)
      ..write(obj.total)
      ..writeByte(6)
      ..write(obj.currency)
      ..writeByte(7)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
