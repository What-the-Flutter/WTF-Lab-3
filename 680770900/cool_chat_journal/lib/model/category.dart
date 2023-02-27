import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String name;

  const Category({
    required this.icon,
    required this.name,
  });
}

class AvailableCategories {
  static final categories = <Category>[
    const Category(icon: Icons.theaters, name: 'Movie'),
    const Category(icon: Icons.fastfood, name: 'Fast Food'),
    const Category(icon: Icons.fitness_center, name: 'Workout'),
    const Category(icon: Icons.sports_basketball, name: 'Sports'),
    const Category(icon: Icons.local_laundry_service, name: 'Laundry'),
  ];
}