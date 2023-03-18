// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DBActivityModel _$$_DBActivityModelFromJson(Map<String, dynamic> json) =>
    _$_DBActivityModel(
      id: json['id'] as String? ?? '_id',
      date: DateTime.parse(json['date'] as String),
      spentTime: json['spentTime'] ?? '0',
    );

Map<String, dynamic> _$$_DBActivityModelToJson(_$_DBActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'spentTime': instance.spentTime,
    };
