import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/strings.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../../theme/theme_scope.dart';
import '../../scope/timeline_scope.dart';

class FilterDateSelector extends StatelessWidget {
  const FilterDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DateSelector(
              action: () {
                TimelineScope.of(context).dateFilter = DateFilter.newOnce;
              },
              buttonText: 'First new',
              width: _width(context, DateFilter.newOnce)!,
              color: _color(context, DateFilter.newOnce)!,
            ),
            const SizedBox(width: Insets.medium),
            _DateSelector(
              action: () {
                TimelineScope.of(context).dateFilter = DateFilter.oldOnce;
              },
              buttonText: 'First old',
              width: _width(context, DateFilter.oldOnce)!,
              color: _color(context, DateFilter.oldOnce)!,
            ),
          ],
        );
      },
    );
  }

  double? _width(BuildContext context, DateFilter filter) =>
      TimelineScope.of(context).state.mapOrNull(
            filterMode: (filterMode) =>
                filterMode.dateFilter == filter.dateFilter ? 200.0 : 120.0,
          );

  int? _color(BuildContext context, DateFilter filter) =>
      TimelineScope.of(context).state.mapOrNull(
            filterMode: (filterMode) =>
                filterMode.dateFilter == filter.dateFilter
                    ? ThemeScope.of(context).state.primaryColor
                    : ThemeScope.of(context).state.primaryItemColor,
          );
}

class _DateSelector extends StatelessWidget {
  final VoidCallback action;
  final String buttonText;
  final double width;
  final int color;

  const _DateSelector({
    super.key,
    required this.action,
    required this.buttonText,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate,
          width: width,
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
              vertical: Insets.small,
            ),
            child: Material(
              color: Color(color),
              borderRadius: BorderRadius.circular(Radii.medium),
              child: InkWell(
                borderRadius: BorderRadius.circular(Radii.medium),
                onTap: action.call,
                child: Center(
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: FontsSize.normal,
                    ),
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

class FilterImageOnlySelector extends StatelessWidget {
  const FilterImageOnlySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: Insets.extraLarge),
          child: Row(
            children: [
              const Text(
                'Images only',
                style: TextStyle(fontSize: FontsSize.large),
              ),
              const Spacer(),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.medium),
                ),
                value: state.mapOrNull(
                  filterMode: (filterMode) => filterMode.imagesOnly,
                ),
                onChanged: (value) {
                  TimelineScope.of(context).imagesOnly = value!;
                },
                activeColor: Color(ThemeScope.of(context).state.primaryColor),
                checkColor: Colors.white,
              ),
              const SizedBox(width: Insets.superDuperUltraMegaExtraLarge * 1.5),
            ],
          ),
        );
      },
    );
  }
}

class FilterAudioOnlySelector extends StatelessWidget {
  const FilterAudioOnlySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: Insets.extraLarge),
          child: Row(
            children: [
              const Text(
                'Audio only',
                style: TextStyle(fontSize: FontsSize.large),
              ),
              const Spacer(),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.medium),
                ),
                value: state.mapOrNull(
                  filterMode: (filterMode) => filterMode.audioOnly,
                ),
                onChanged: (value) {
                  TimelineScope.of(context).audioOnly = value!;
                },
                activeColor: Color(ThemeScope.of(context).state.primaryColor),
                checkColor: Colors.white,
              ),
              const SizedBox(width: Insets.superDuperUltraMegaExtraLarge * 1.5),
            ],
          ),
        );
      },
    );
  }
}
