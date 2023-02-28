// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirebaseTagModel _$$_FirebaseTagModelFromJson(Map<String, dynamic> json) =>
    _$_FirebaseTagModel(
      id: json['id'] as String? ?? '_id',
      tagTitle: json['tagTitle'] as String? ?? '_tag_title',
      tagIcon: json['tagIcon'] as int? ?? 0,
    );

Map<String, dynamic> _$$_FirebaseTagModelToJson(_$_FirebaseTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagTitle': instance.tagTitle,
      'tagIcon': instance.tagIcon,
    };
