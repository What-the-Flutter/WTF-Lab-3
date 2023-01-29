import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/multi_selector/multi_selector_cubit.dart';

class MultiSelectorScope<T extends Object> extends StatelessWidget {
  const MultiSelectorScope({
    super.key,
    required this.child,
    required this.items,
    this.selectedItems,
  });

  final Widget child;
  final IList<T> items;
  final ISet<T>? selectedItems;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MultiSelectorCubit(
        items: items,
        selectedItems: selectedItems,
      ),
      child: child,
    );
  }
}
