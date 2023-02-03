import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/chat.dart';

final List<Chat> sourceChats = [];

final List<Category> categories = [
  Category(Icons.cancel, 'Cancel'),
  Category(Icons.fastfood, 'FastFood'),
  Category(Icons.directions_run, 'Running'),
  Category(Icons.local_laundry_service, 'Laundry'),
  Category(Icons.local_movies, 'Movie'),
  Category(Icons.fitness_center, 'Workout'),
  Category(Icons.sports_basketball, 'Sports'),
];
