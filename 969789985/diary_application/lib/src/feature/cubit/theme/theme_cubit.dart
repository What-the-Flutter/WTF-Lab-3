import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/data/repository/theme/theme_repository.dart';
import '../../../core/domain/repository/theme/api_theme_repository.dart';
import '../../../core/util/logger.dart';
import '../../../core/util/resources/dimensions.dart';
import '../../../core/util/resources/themes.dart';

part 'theme_state.dart';

part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ApiThemeRepository _repository;

  ThemeCubit({
    required ApiThemeRepository repository,
  })  : _repository = repository,
        super(
          ThemeState(
            isDarkMode: repository.isDarkMode,
            messageFontSize: repository.messageFontSize,
            messageBorderRadius: repository.messageBorderRadius,
            primaryColor: repository.primaryColor,
            primaryItemColor: repository.primaryItemColor,
            messageAlignment: repository.messageAlignment,
            dateBubbleVisible: repository.dateBubbleVisible,
            chatBackgroundColor: repository.chatBackgroundColor,
            imagePath: repository.imagePath,
            image: null,
          ),
        ) {
    if (_repository.imagePath != '') {
      emit(
        state.copyWith(
          image: File(repository.imagePath),
        ),
      );
    }
  }

  void imagePath(String path) async {
    if (state.imagePath != '') {
      try {
        final file = File(state.imagePath);
        await file.delete();
      } on Exception catch (e) {
        logger('Removing exception: $e', 'File_removing');
      }
    }

    _repository.setImagePath(path);
    emit(
      state.copyWith(
        chatBackgroundColor: -1,
        imagePath: path,
        image: File(path),
      ),
    );
  }

  set chatBackgroundColor(int color) {
    _repository.setChatBackgroundColor(color);
    emit(
      state.copyWith(
        chatBackgroundColor: color,
        imagePath: '',
      ),
    );
  }

  set dateBubbleVisible(bool value) {
    _repository.setDateBubbleVisible(value);
    emit(
      state.copyWith(dateBubbleVisible: value),
    );
  }

  set messageAlignment(BubbleAlignments alignment) {
    _repository.setMessageAlignment(alignment.alignment);
    emit(
      state.copyWith(messageAlignment: alignment.alignment),
    );
  }

  set isDarkMode(bool value) {
    _repository.setDarkMode(value);
    emit(
      state.copyWith(isDarkMode: value),
    );
  }

  set messageFontSize(double value) {
    _repository.setMessageFontSize(value);
    emit(
      state.copyWith(messageFontSize: value),
    );
  }

  set messageBorderRadius(double value) {
    _repository.setMessageBorderRadius(value);
    emit(
      state.copyWith(messageBorderRadius: value),
    );
  }

  void setColors(int primaryColor, int primaryItemColor) {
    _repository.setColors(primaryColor, primaryItemColor);
    emit(
      state.copyWith(
        primaryColor: primaryColor,
        primaryItemColor: primaryItemColor,
      ),
    );
  }

  void changeTheme() {
    _repository.setDarkMode(!state.isDarkMode);
    emit(
      state.copyWith(
        isDarkMode: !state.isDarkMode,
      ),
    );
  }

  void resetSettings() {
    _repository.setMessageFontSize(FontsSize.standard);
    _repository.setMessageBorderRadius(35.0);
    state.isDarkMode
        ? _repository.setColors(
            AppColors.primaryDark,
            AppColors.primaryItemDark,
          )
        : _repository.setColors(
            AppColors.primaryLight,
            AppColors.primaryItemLight,
          );
    _repository.setMessageAlignment(BubbleAlignments.end.alignment);
    _repository.setDateBubbleVisible(true);
    _repository.setImagePath('');
    _repository.setChatBackgroundColor(-1);

    emit(
      state.copyWith(
        messageFontSize: FontsSize.standard,
        messageBorderRadius: 35.0,
        primaryColor:
            state.isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
        primaryItemColor: state.isDarkMode
            ? AppColors.primaryItemDark
            : AppColors.primaryItemLight,
        messageAlignment: BubbleAlignments.end.alignment,
        dateBubbleVisible: true,
        chatBackgroundColor: -1,
        imagePath: '',
        image: null,
      ),
    );
  }
}
