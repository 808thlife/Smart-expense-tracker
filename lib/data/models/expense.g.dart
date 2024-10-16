// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 2;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      comment: fields[3] as String?,
      expense: fields[4] as double,
      category: fields[5] as ExpenseCategoryEnum,
      title: fields[2] as String,
      timestamp: fields[1] as DateTime,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.expense)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseCategoryEnumAdapter extends TypeAdapter<ExpenseCategoryEnum> {
  @override
  final int typeId = 0;

  @override
  ExpenseCategoryEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategoryEnum.leisure;
      case 1:
        return ExpenseCategoryEnum.transportation;
      case 2:
        return ExpenseCategoryEnum.cafe;
      case 3:
        return ExpenseCategoryEnum.services;
      case 4:
        return ExpenseCategoryEnum.streamings;
      case 5:
        return ExpenseCategoryEnum.other;
      default:
        return ExpenseCategoryEnum.leisure;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategoryEnum obj) {
    switch (obj) {
      case ExpenseCategoryEnum.leisure:
        writer.writeByte(0);
        break;
      case ExpenseCategoryEnum.transportation:
        writer.writeByte(1);
        break;
      case ExpenseCategoryEnum.cafe:
        writer.writeByte(2);
        break;
      case ExpenseCategoryEnum.services:
        writer.writeByte(3);
        break;
      case ExpenseCategoryEnum.streamings:
        writer.writeByte(4);
        break;
      case ExpenseCategoryEnum.other:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
