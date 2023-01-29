import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/single_selector/single_selector_cubit.dart';

class SingleSelectorScope<T extends Object> extends StatelessWidget {
  const SingleSelectorScope({
    super.key,
    required this.child,
    required this.items,
    this.selectedItem,
  });

  final Widget child;
  final IList<T> items;
  final T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SingleSelectorCubit(
        items: items,
        selectedItem: selectedItem,
      ),
      child: child,
    );
  }
}
