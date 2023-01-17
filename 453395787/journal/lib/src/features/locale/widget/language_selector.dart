import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/insets.dart';
import '../cubit/locale_cubit.dart';
import '../data/locale_repository_api.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        Insets.medium,
      ),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: LocaleRepositoryApi.localeNames.length,
            itemBuilder: (context, index) {
              final color = LocaleRepositoryApi.supportedLocales[index];

              return CheckboxListTile(
                title: Text(LocaleRepositoryApi.localeNames[index].i18n()),
                value: color == state.locale,
                onChanged: (isChecked) {
                  if (isChecked != null && isChecked) {
                    context.read<LocaleCubit>().setLocale(color);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
