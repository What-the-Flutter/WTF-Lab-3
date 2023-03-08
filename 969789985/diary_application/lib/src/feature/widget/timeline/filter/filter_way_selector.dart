import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../theme/theme_scope.dart';
import '../scope/timeline_scope.dart';

class FilterWaySelector extends StatelessWidget {
  const FilterWaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SelectorButton(
                action: () => _setFilterWay(context, 0),
                buttonText: 'Chats',
                width: _width(context, 0)!,
                height: _height(context, 0)!,
                color: _color(context, 0)!,
              ),
              const SizedBox(width: Insets.medium),
              _SelectorButton(
                action: () => _setFilterWay(context, 1),
                buttonText: 'Tags',
                width: _width(context, 1)!,
                height: _height(context, 1)!,
                color: _color(context, 1)!,
              ),
              const SizedBox(width: Insets.medium),
              _SelectorButton(
                action: () => _setFilterWay(context, 2),
                buttonText: 'Filter',
                width: _width(context, 2)!,
                height: _height(context, 2)!,
                color: _color(context, 2)!,
              ),
              const SizedBox(width: Insets.medium),
              _SelectorButton(
                action: () => _setFilterWay(context, 3),
                buttonText: 'Search',
                width: _width(context, 3)!,
                height: _height(context, 3)!,
                color: _color(context, 3)!,
              ),
            ],
          ),
        );
      },
    );
  }

  double? _width(BuildContext context, int filterWay) =>
      TimelineScope.of(context).state.map(
            defaultMode: (defaultMode) => 0.0,
            filterMode: (filterMode) =>
                filterMode.filterWay == filterWay ? 100.0 : 80.0,
          );

  double? _height(BuildContext context, int filterWay) =>
      TimelineScope.of(context).state.map(
            defaultMode: (defaultMode) => 0.0,
            filterMode: (filterMode) =>
                filterMode.filterWay == filterWay ? 70.0 : 60.0,
          );

  int? _color(BuildContext context, int filterWay) =>
      TimelineScope.of(context).state.map(
            defaultMode: (defaultMode) => Colors.transparent.value,
            filterMode: (filterMode) => filterMode.filterWay == filterWay
                ? ThemeScope.of(context).state.primaryColor
                : ThemeScope.of(context).state.primaryItemColor,
          );

  void _setFilterWay(BuildContext context, int filterWay) {
    TimelineScope.of(context).filterWay = filterWay;
  }
}

class _SelectorButton extends StatelessWidget {
  final Callback action;
  final String buttonText;
  final double width;
  final double height;
  final int color;

  const _SelectorButton({
    super.key,
    required this.action,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.circular(Radii.appConstantSmall),
      ),
      child: MaterialButton(
        onPressed: action.call,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstantSmall),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.large),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: FontsSize.normal,
            ),
          ),
        ),
      ),
    );
  }
}
