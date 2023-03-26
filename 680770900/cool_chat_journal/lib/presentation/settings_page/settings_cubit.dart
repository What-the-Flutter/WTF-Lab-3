import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repository/settings_repository.dart';
import '../../data/models/theme_info.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static final defaultThemeType = ThemeType.light;
  static final defaultFontSizeType = FontSizeType.medium;
  static final defaultBubbleAlignmentType = BubbleAlignmentType.left;

  SettingsCubit() : super(const SettingsState());

  Future<void> initSettings() async {
    await initTheme();
    await uploadBackgroundImage();
  }

  Future<void> initTheme() async {
    final themeTypeConverter = 
      _Converter(
        values: ThemeType.values,
        defaultValue: defaultThemeType,
      );

    final fontSizeTypeConverter = 
      _Converter(
        values: FontSizeType.values,
        defaultValue: defaultFontSizeType,
      );

    final bubbleAlignmentTypeConverter = 
      _Converter(
        values: BubbleAlignmentType.values,
        defaultValue: defaultBubbleAlignmentType,
      );

    final themeInfo = await GetIt.I<SettingsRepository>().updateThemeInfo();

    emit(
      state.copyWith(
        themeType: themeTypeConverter.fromString(themeInfo.themeType),
        fontSizeType: fontSizeTypeConverter.fromString(themeInfo.fontSize),
        bubbleAlignmentType:
          bubbleAlignmentTypeConverter.fromString(themeInfo.bubbleAlignment),
      ),
    );
  }

  Future<void> switchBubbleAlignmentType() async {
    final bubbleAlignmentType = state.bubbleAlignmentType.next;

    await GetIt.I<SettingsRepository>().saveThemeInfo(
      ThemeInfo(
        themeType: state.themeType.name,
        fontSize: state.fontSizeType.name,
        bubbleAlignment: bubbleAlignmentType.name,
      )
    );

    emit(state.copyWith(bubbleAlignmentType: bubbleAlignmentType));
  }

  Future<void> switchThemeType() async {
    final themeType = state.themeType.next;

    await GetIt.I<SettingsRepository>().saveThemeInfo(
      ThemeInfo(
        themeType: themeType.name,
        fontSize: state.fontSizeType.name,
        bubbleAlignment: state.bubbleAlignmentType.name,
      ),
    );

    emit(state.copyWith(themeType: themeType));
  }

  Future<void> switchFontSizeType(FontSizeType fontSizeType) async {
    await GetIt.I<SettingsRepository>().saveThemeInfo(
      ThemeInfo(
        themeType: state.themeType.name,
        fontSize: fontSizeType.name,
        bubbleAlignment: state.bubbleAlignmentType.name,
      ),
    );

    emit(state.copyWith(fontSizeType: fontSizeType));
  }

  Future<void> uploadBackgroundImage() async {
    try {
      final image = 
          await GetIt.I<SettingsRepository>().downloadBackgroundImage();

      emit(
        state.copyWith(
          backgroundImage: _NullWrapper(value: image),
        ),
      );
    } catch (_) { }
  }

  Future<void> resetBackgroundImage() async {
    await GetIt.I<SettingsRepository>().deleteBackgroundImage();

    emit(
      state.copyWith(
        backgroundImage: const _NullWrapper(value: null),
      ),
    );
  }

  Future<void> saveBackgroundImage(Uint8List backgroundImage) async {
    await GetIt.I<SettingsRepository>().saveBackgroundImage(backgroundImage);

    emit(
      state.copyWith(
        backgroundImage: _NullWrapper(value: backgroundImage),
      ),
    );
  }

  Future<void> restoreSettings() async {
    await GetIt.I<SettingsRepository>().saveThemeInfo(
      ThemeInfo(
        themeType: defaultThemeType.name,
        fontSize: defaultFontSizeType.name,
        bubbleAlignment: defaultBubbleAlignmentType.name,
      ),
    );

    emit(
      state.copyWith(
        themeType: defaultThemeType,
        fontSizeType: defaultFontSizeType,
        bubbleAlignmentType: defaultBubbleAlignmentType,
      ),
    );
  }
}
