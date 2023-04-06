import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/settings_repository.dart';
import '../../data/models/theme_enums.dart';
import '../../data/models/theme_info.dart';
import '../../utils/converter.dart';
import '../../utils/null_wrapper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static final defaultThemeType = ThemeType.light;
  static final defaultFontSizeType = FontSizeType.medium;
  static final defaultBubbleAlignmentType = BubbleAlignmentType.left;

  final SettingsRepository _settingsRepository;

  SettingsCubit(this._settingsRepository) : super(const SettingsState());

  Future<void> initSettings() async {
    await initTheme();
    await uploadBackgroundImage();
  }

  Future<void> initTheme() async {
    final themeTypeConverter = Converter(
      values: ThemeType.values,
      defaultValue: defaultThemeType,
    );

    final fontSizeTypeConverter = Converter(
      values: FontSizeType.values,
      defaultValue: defaultFontSizeType,
    );

    final bubbleAlignmentTypeConverter = Converter(
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
    emit(state.copyWith(bubbleAlignmentType: bubbleAlignmentType));

    await _settingsRepository.saveThemeInfo(ThemeInfo(
      themeType: state.themeType.name,
      fontSize: state.fontSizeType.name,
      bubbleAlignment: bubbleAlignmentType.name,
    ));
  }

  Future<void> switchThemeType() async {
    final themeType = state.themeType.next;
    emit(state.copyWith(themeType: themeType));

    await _settingsRepository.saveThemeInfo(
      ThemeInfo(
        themeType: themeType.name,
        fontSize: state.fontSizeType.name,
        bubbleAlignment: state.bubbleAlignmentType.name,
      ),
    );
  }

  Future<void> switchFontSizeType(FontSizeType fontSizeType) async {
    emit(state.copyWith(fontSizeType: fontSizeType));

    await _settingsRepository.saveThemeInfo(
      ThemeInfo(
        themeType: state.themeType.name,
        fontSize: fontSizeType.name,
        bubbleAlignment: state.bubbleAlignmentType.name,
      ),
    );
  }

  Future<void> uploadBackgroundImage() async {
    try {
      final image = await _settingsRepository.downloadBackgroundImage();

      emit(
        state.copyWith(
          backgroundImage: NullWrapper(image),
        ),
      );
    } catch (_) {}
  }

  Future<void> resetBackgroundImage() async {
    emit(
      state.copyWith(
        backgroundImage: const NullWrapper(null),
      ),
    );

    await _settingsRepository.deleteBackgroundImage();
  }

  Future<void> saveBackgroundImage(Uint8List backgroundImage) async {
    emit(
      state.copyWith(
        backgroundImage: NullWrapper(backgroundImage),
      ),
    );

    await _settingsRepository.saveBackgroundImage(backgroundImage);
  }

  Future<void> restoreSettings() async {
    emit(
      state.copyWith(
        themeType: defaultThemeType,
        fontSizeType: defaultFontSizeType,
        bubbleAlignmentType: defaultBubbleAlignmentType,
      ),
    );
    
    await _settingsRepository.saveThemeInfo(
      ThemeInfo(
        themeType: defaultThemeType.name,
        fontSize: defaultFontSizeType.name,
        bubbleAlignment: defaultBubbleAlignmentType.name,
      ),
    );
  }
}
