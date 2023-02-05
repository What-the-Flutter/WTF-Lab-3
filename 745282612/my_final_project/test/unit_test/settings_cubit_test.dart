import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/utils/theme/app_theme.dart';

void main() {
  group('CounterBloc', () {
    late SettingCubit settingCubit;
    final user = MockUser(
      isAnonymous: true,
    );

    setUp(
      () {
        WidgetsFlutterBinding.ensureInitialized();
        settingCubit = SettingCubit(user: user);
      },
    );

    blocTest<SettingCubit, SettingState>(
      'Test changeBubbleAligment',
      build: () => settingCubit,
      setUp: () => SharedPreferences.setMockInitialValues({}),
      seed: () => SettingState(
        listSection: [],
        theme: AppTheme.lightTheme,
        textTheme: AppFontSize.mediumFontSize,
        backgroundImage: '',
        bubbleAlignment: 'left',
        dateBubble: 'left',
      ),
      act: (bloc) => bloc.changeBubbleAligment(),
      expect: () => [
        SettingState(
          listSection: [],
          theme: AppTheme.lightTheme,
          textTheme: AppFontSize.mediumFontSize,
          backgroundImage: '',
          bubbleAlignment: 'right',
          dateBubble: 'left',
        ),
      ],
    );

    blocTest<SettingCubit, SettingState>(
      'Test changeDateBubble',
      build: () => settingCubit,
      setUp: () => SharedPreferences.setMockInitialValues({}),
      seed: () => SettingState(
        listSection: [],
        theme: AppTheme.lightTheme,
        textTheme: AppFontSize.mediumFontSize,
        backgroundImage: '',
        bubbleAlignment: 'left',
        dateBubble: 'left',
      ),
      act: (bloc) => bloc.changeDateBubble(),
      expect: () => [
        SettingState(
          listSection: [],
          theme: AppTheme.lightTheme,
          textTheme: AppFontSize.mediumFontSize,
          backgroundImage: '',
          bubbleAlignment: 'left',
          dateBubble: 'center',
        ),
      ],
    );

    blocTest<SettingCubit, SettingState>(
      'Test changeFontSize',
      build: () => settingCubit,
      setUp: () => SharedPreferences.setMockInitialValues({}),
      seed: () => SettingState(
        listSection: [],
        theme: AppTheme.lightTheme,
        textTheme: AppFontSize.smallFontSize,
        backgroundImage: '',
        bubbleAlignment: 'left',
        dateBubble: 'left',
      ),
      act: (bloc) => bloc.changeFontSize(),
      expect: () => [
        SettingState(
          listSection: [],
          theme: AppTheme.lightTheme,
          textTheme: AppFontSize.mediumFontSize,
          backgroundImage: '',
          bubbleAlignment: 'left',
          dateBubble: 'left',
        ),
      ],
    );

    blocTest<SettingCubit, SettingState>(
      'Test resetSetting',
      build: () => settingCubit,
      setUp: () => SharedPreferences.setMockInitialValues({}),
      seed: () => SettingState(
        listSection: [],
        theme: AppTheme.darkTheme,
        textTheme: AppFontSize.smallFontSize,
        backgroundImage: '',
        bubbleAlignment: 'right',
        dateBubble: 'center',
      ),
      act: (bloc) => bloc.resetSetting(),
      expect: () => [
        SettingState(
          listSection: [],
          theme: AppTheme.lightTheme,
          textTheme: AppFontSize.mediumFontSize,
          backgroundImage: '',
          bubbleAlignment: 'left',
          dateBubble: 'left',
        ),
      ],
    );

    blocTest<SettingCubit, SettingState>(
      'Test changeTheme',
      build: () => settingCubit,
      setUp: () => SharedPreferences.setMockInitialValues({}),
      seed: () => SettingState(
        listSection: [],
        theme: AppTheme.darkTheme,
        textTheme: AppFontSize.smallFontSize,
        backgroundImage: '',
        bubbleAlignment: 'right',
        dateBubble: 'center',
      ),
      act: (bloc) => bloc.changeTheme(),
      expect: () => [
        SettingState(
          listSection: [],
          theme: AppTheme.lightTheme,
          textTheme: AppFontSize.smallFontSize,
          backgroundImage: '',
          bubbleAlignment: 'right',
          dateBubble: 'center',
        ),
      ],
    );
  });
}
