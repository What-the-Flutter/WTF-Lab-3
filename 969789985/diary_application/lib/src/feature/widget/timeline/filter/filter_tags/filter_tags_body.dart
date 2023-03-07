import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/tag/tag_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../theme/theme_scope.dart';
import '../../scope/timeline_scope.dart';

class FilterTagsBody extends StatelessWidget {
  const FilterTagsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineScope.of(context).state.tags.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.eco_rounded, size: IconsSize.large),
                Text(
                  'Oops...\nTags don\'t seem to exist. ☺',
                  style: TextStyle(
                    fontSize: FontsSize.large,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const _FilterWaySwitch(),
                    const SizedBox(height: Insets.large),
                    Wrap(
                      alignment: WrapAlignment.end,
                      children: TimelineScope.of(context)
                          .state
                          .tags
                          .map(
                            (tag) => _TagBox(tag: tag),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

class _TagBox extends StatelessWidget {
  final TagModel tag;

  const _TagBox({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.small * 1.2,
            vertical: Insets.small * 1.5,
          ),
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 300),
            width: state.mapOrNull(
              filterMode: (filterMode) =>
                  filterMode.tagIds.contains(tag.id) ? 120.0 : 105.0,
            ),
            height: state.mapOrNull(
              filterMode: (filterMode) =>
                  filterMode.tagIds.contains(tag.id) ? 50.0 : 40.0,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(Radii.medium),
              color: state.mapOrNull(
                filterMode: (filterMode) => filterMode.tagIds.contains(tag.id)
                    ? Color(ThemeScope.of(context).state.primaryColor)
                    : Color(ThemeScope.of(context).state.primaryItemColor),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(Radii.medium),
                onTap: () =>
                    TimelineScope.of(context).updateSelectableTags(tag.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Insets.small,
                    horizontal: Insets.small,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(
                          tag.tagIcon,
                          fontFamily: AppIcons.material,
                        ),
                      ),
                      const SizedBox(width: Insets.small),
                      Text(tag.tagTitle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FilterWaySwitch extends StatelessWidget {
  const _FilterWaySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.extraLarge),
          child: Row(
            children: [
              const Text(
                'Strong filter',
                style: TextStyle(
                  fontSize: FontsSize.large,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: Insets.large),
              CupertinoSwitch(
                value: state.map(
                    defaultMode: (defaultMode) => false,
                    filterMode: (filterMode) => filterMode.strongTagFilter),
                onChanged: (value) {
                  TimelineScope.of(context).strongTagFilter = value;
                  TimelineScope.of(context).clearTagFilters();
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        );
      },
    );
  }
}
