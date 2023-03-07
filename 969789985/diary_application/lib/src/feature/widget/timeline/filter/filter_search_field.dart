import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../theme/theme_scope.dart';
import '../scope/timeline_scope.dart';

class FilterSearchField extends StatefulWidget {
  const FilterSearchField({super.key});

  @override
  State<FilterSearchField> createState() => _FilterSearchFieldState();
}

class _FilterSearchFieldState extends State<FilterSearchField> {
  late final TextEditingController _searchTextFieldController;

  @override
  void initState() {
    super.initState();

    _searchTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.large),
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.circle),
          color: Color(ThemeScope.of(context).state.primaryItemColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.large),
          child: TextField(
            controller: _searchTextFieldController,
            onChanged: (query) {
              TimelineScope.of(context).onSearchQueryChanged(query);
              query.isEmpty
                  ? TimelineScope.of(context).filterWay = 0
                  : TimelineScope.of(context).filterWay = 3;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _ClearQueryButton(
                  action: _searchTextFieldController.clear,
                ),
                hintText: 'Search here...'),
          ),
        ),
      ),
    );
  }
}

class _ClearQueryButton extends StatelessWidget {
  final Callback action;

  const _ClearQueryButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return AnimatedScale(
          scale: state.map(
            defaultMode: (defaultMode) => 0.0,
            filterMode: (filterMode) =>
                filterMode.searchQuery.isEmpty ? 0.0 : 1.0,
          )!,
          duration: const Duration(milliseconds: 150),
          child: IconButton(
            onPressed: () {
              TimelineScope.of(context).onSearchQueryChanged('');
              action.call();
            },
            icon: const Icon(Icons.close),
          ),
        );
      },
    );
  }
}
