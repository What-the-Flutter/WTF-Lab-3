import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../pages/settings/settings_cubit.dart';

class DateCard extends StatelessWidget {
  final DateTime _date;

  const DateCard({required DateTime date, Key? key})
      : _date = date,
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => Row(
          mainAxisAlignment: state.isCenterDate
              ? MainAxisAlignment.center
              : state.isRightToLeft
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Text(
                DateFormat('dd.MM.yyyy').format(_date),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.9),
                    ),
              ),
            ),
          ],
        ),
      );
}
