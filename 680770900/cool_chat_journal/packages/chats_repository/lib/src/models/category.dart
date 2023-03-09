import 'package:chats_api/chats_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Category extends Equatable {
  static final List<Category> basic = <Category>[
    Category(
      title: 'Movie',
      icon: Icons.theaters,
      isCustom: false,
    ),
    Category(
      title: 'FastFood',
      icon: Icons.fastfood,
      isCustom: false,
    ),
    Category(
      title: 'Workout',
      icon: Icons.fitness_center,
      isCustom: false,
    ),
    Category(
      title: 'Sports',
      icon: Icons.sports_basketball,
      isCustom: false,
    ),
    Category(
      title: 'Laundry',
      icon: Icons.local_laundry_service,
      isCustom: false,
    ),
  ];

  final String id;
  final String title;
  final IconData icon;
  final bool isCustom;

  Category({
    String? id,
    required this.title,
    required this.icon,
    required this.isCustom,
  }) : id = id ?? const Uuid().v4();

  factory Category.fromCategoryEntity(CategoryEntity categoryEntity) =>
    Category(
      id: categoryEntity.id,
      title: categoryEntity.title,
      icon: IconData(categoryEntity.icon, fontFamily: 'MaterialIcons'),
      isCustom: categoryEntity.isCustom,
    ); 

  CategoryEntity toCategoryEntity() =>
    CategoryEntity(
      id: id,
      title: title,
      icon: icon.codePoint,
      isCustom: isCustom,
    );

  Category copyWith({
    String? id,
    String? title,
    IconData? icon,
    bool? isCustom,
  }) => Category(
    id: id ?? this.id,
    title: title ?? this.title,
    icon: icon ?? this.icon,
    isCustom: isCustom ?? this.isCustom,
  ); 
  
  @override
  List<Object?> get props => [
    id,
    title,
    icon,
    isCustom,
  ];
}
