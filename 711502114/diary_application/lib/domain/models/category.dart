import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final IconData icon;
  final String title;

  Category(this.icon, this.title);

  Category copyWith({IconData? icon, String? title}) {
    return Category(icon ?? this.icon, title ?? this.title);
  }

  @override
  List<Object?> get props => [icon, title];

  static Category? model(String title) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].title == title) return list[i];
    }

    return null;
  }

  static final List<Category> list = [
    Category(Icons.cancel, 'Cancel'),
    Category(Icons.fastfood, 'FastFood'),
    Category(Icons.directions_run, 'Running'),
    Category(Icons.local_laundry_service, 'Laundry'),
    Category(Icons.local_movies, 'Movie'),
    Category(Icons.fitness_center, 'Workout'),
    Category(Icons.sports_basketball, 'Sports'),
  ];
}
