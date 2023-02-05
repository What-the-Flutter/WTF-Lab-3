import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_state.dart';
import 'package:my_final_project/utils/theme/app_theme.dart';

void main() {
  group('CounterBloc', () {
    late SettingCubit settingCubit;
    final user = MockUser(
      isAnonymous: true,
    );

    setUp(() {
      settingCubit = SettingCubit(user: user);
    });

    blocTest<SettingCubit, SettingState>(
      'emits [1] when CounterIncrementPressed is added',
      setUp: () => SharedPreferences.setMockInitialValues({}),
      build: () => settingCubit,
      act: (bloc) => bloc.changeTheme(),
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
  });
  // late SettingCubit settingCubit;
  // final user = MockUser(
  //   isAnonymous: true,
  // );
  // setUp(() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   settingCubit = SettingCubit(user: user);
  // });

  // blocTest<SettingCubit, SettingState>(
  //   'changeTheme',
  //   setUp: () => SharedPreferences.setMockInitialValues({}),
  //   build: () => settingCubit,
  //   seed: () => SettingState(
  //     isAdd: false,
  //     listSection: [],
  //     textTheme: SettingState.defaultTextTheme,
  //     backgroundImage: '',
  //     bubbleAlignment: 'left',
  //     dateBubble: 'left',
  //     theme: AppTheme.darkTheme,
  //   ),
  //   act: (bloc) => bloc.changeTheme,
  //   expect: () => [
  //     SettingState(
  //       isAdd: false,
  //       listSection: [],
  //       textTheme: SettingState.defaultTextTheme,
  //       backgroundImage: '',
  //       bubbleAlignment: 'left',
  //       dateBubble: 'left',
  //       theme: AppTheme.lightTheme,
  //     ),
  //   ],
  // );
}
