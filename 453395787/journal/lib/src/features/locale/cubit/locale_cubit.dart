import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/locale_repository_api.dart';

part 'locale_state.dart';

part 'locale_cubit.freezed.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({
    required LocaleRepositoryApi localeRepository,
  })  : _repository = localeRepository,
        super(
          const LocaleState.system(),
        );

  final LocaleRepositoryApi _repository;

  void setLocale(Locale locale) {
    _repository.setLocale(locale);
    emit(
      LocaleState.custom(locale: locale),
    );
  }
}
