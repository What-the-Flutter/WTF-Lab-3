import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/category.dart';

class CategoryStore {
  final BuildContext context;
  AppLocalizations? _local;
  late final List<Category> categories;

  CategoryStore({required this.context}) {
    _local = AppLocalizations.of(context);

    categories = [
      Category(Icons.cancel, _local?.cancel ?? ''),
      Category(Icons.fastfood, _local?.fastFood ?? ''),
      Category(Icons.directions_run, _local?.running ?? ''),
      Category(Icons.local_laundry_service, _local?.laundry ?? ''),
      Category(Icons.local_movies, _local?.movie ?? ''),
      Category(Icons.fitness_center, _local?.workout ?? ''),
      Category(Icons.sports_basketball, _local?.sports ?? ''),
    ];
  }
}
