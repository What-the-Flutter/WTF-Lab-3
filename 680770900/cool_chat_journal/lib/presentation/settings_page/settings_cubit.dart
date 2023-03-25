import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/repository/settings_repository.dart';
import '../../data/models/theme_info.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static final defaultThemeType = ThemeType.light;
  static final defaultFontSizeType = FontSizeType.medium;
  static final defaultBubbleAlignmentType = BubbleAlignmentType.left;

  final SettingsRepository _settingsRepository;

  SettingsCubit({required User? user})
    : _settingsRepository = SettingsRepository(user),
      super(const SettingsState());

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

    final themeInfo = await _settingsRepository.updateThemeInfo();

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

    await _settingsRepository.saveThemeInfo(
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

    await _settingsRepository.saveThemeInfo(
      ThemeInfo(
        themeType: themeType.name,
        fontSize: state.fontSizeType.name,
        bubbleAlignment: state.bubbleAlignmentType.name,
      ),
    );

    emit(state.copyWith(themeType: themeType));
  }

  Future<void> switchFontSizeType(FontSizeType fontSizeType) async {
    await _settingsRepository.saveThemeInfo(
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
      final image = await _settingsRepository.downloadBackgroundImage();

      emit(
        state.copyWith(
          backgroundImage: _NullWrapper(value: image),
        ),
      );
    } catch (_) { }
  }

  Future<void> resetBackgroundImage() async {
    await _settingsRepository.deleteBackgroundImage();

    emit(
      state.copyWith(
        backgroundImage: const _NullWrapper(value: null),
      ),
    );
  }

  Future<void> saveBackgroundImage(Uint8List backgroundImage) async {
    await _settingsRepository.saveBackgroundImage(backgroundImage);

    emit(
      state.copyWith(
        backgroundImage: _NullWrapper(value: backgroundImage),
      ),
    );
  }

  Future<void> restoreSettings() async {
    await _settingsRepository.saveThemeInfo(
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
