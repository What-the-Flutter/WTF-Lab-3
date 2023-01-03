import 'package:flutter/material.dart';
import 'package:my_final_project/entities/section.dart';

class AppSection {
  static final List<Section> listSection = [
    Section(
      iconSection: Icons.cancel,
      titleSection: 'Cancel',
    ),
    Section(
      iconSection: Icons.movie,
      titleSection: 'Movie',
    ),
    Section(
      iconSection: Icons.fastfood,
      titleSection: 'FastFood',
    ),
    Section(
      iconSection: Icons.sports,
      titleSection: 'Workout',
    ),
    Section(
      iconSection: Icons.directions_run_rounded,
      titleSection: 'Runner',
    ),
    Section(
      iconSection: Icons.shopping_basket_rounded,
      titleSection: 'Shopping',
    ),
    Section(
      iconSection: Icons.travel_explore,
      titleSection: 'Travel',
    ),
    Section(
      iconSection: Icons.explore,
      titleSection: 'Explore',
    ),
  ];
}
