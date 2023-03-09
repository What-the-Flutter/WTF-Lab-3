import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Equatable {
  final String id;
  final String title;
  final int icon;
  final bool isCustom;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.isCustom,
  });

  factory CategoryEntity.fromJson(JsonMap json) =>
    _$CategoryEntityFromJson(json);  

  JsonMap toJson() => _$CategoryEntityToJson(this);

  CategoryEntity copyWith({
    String? id,
    String? title,
    int? icon,
    bool? isCustom,
  }) => CategoryEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    icon: icon ?? this.icon,
    isCustom: isCustom ?? this.isCustom,
  );
  
  @override
  List<Object?> get props => [
    id,
    icon, 
    title,
    isCustom,
  ];
}
