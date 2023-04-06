import 'package:cool_chat_journal/data/data.dart';
import 'package:cool_chat_journal/data/models/theme_enums.dart';
import 'package:cool_chat_journal/presentation/presentation.dart';
import 'package:cool_chat_journal/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'integration_test.mocks.dart';

@GenerateMocks([StorageProvider, HomeCubit])
void main() {
  group('SettingsPage', () {
    testWidgets('change font size', (tester) async {
      final storageProvider = MockStorageProvider();

      GetIt.I.registerSingleton<SettingsProvider>(SettingsProvider());
      GetIt.I.registerSingleton<SettingsRepository>(SettingsRepository(
        GetIt.I<SettingsProvider>(),
        storageProvider,
      ));
      GetIt.I.registerSingleton<SettingsCubit>(SettingsCubit(
        GetIt.I<SettingsRepository>(),
      ));

      await tester.pumpWidget(
        CustomTheme(
          themeData: ThemeData.dark(),
          themeType: ThemeType.dark,
          bubbleAlignmentType: BubbleAlignmentType.left,
          fontSizeType: FontSizeType.medium,
          backgroundImage: null,
          child: MaterialApp(
            home: BlocProvider(
              create: (_) => GetIt.I<SettingsCubit>(),
              child: const SettingsPage(),
            ),
          ),
        ),
      );

      final fontDialogButton = find.ancestor(
        of: find.text('Font Size'),
        matching: find.byType(ListTile),
      );
      expect(fontDialogButton, findsOneWidget);

      // Open Font Dialog.
      await tester.tap(fontDialogButton);
      await tester.pumpAndSettle();

      final smallFontButton = find.ancestor(
        of: find.text('Small'),
        matching: find.byType(TextButton),
      );
      expect(smallFontButton, findsOneWidget);

      // Set small font.
      await tester.tap(smallFontButton);
      await tester.pumpAndSettle();
      expect(GetIt.I<SettingsCubit>().state.fontSizeType, FontSizeType.small);

      final resetButton = find.ancestor(
        of: find.text('Reset All Preferences'),
        matching: find.byType(ListTile),
      );
      expect(resetButton, findsOneWidget);

      // Reset font.      
      await tester.tap(resetButton);
      await tester.pumpAndSettle();
      expect(GetIt.I<SettingsCubit>().state.fontSizeType, FontSizeType.medium);
    });
  });

  group('ChatEditorPage', () {
    testWidgets('edit chat', (tester) async {
      final createdDate = DateTime.now();
      final newName = 'New Chat';

      final sourceChat = Chat(
        iconCode: 42,
        name: 'Source Chat',
        createdTime: createdDate,
        isPinned: false,
      );

      final newChat = sourceChat.copyWith(name: newName);

      final homeCubit = MockHomeCubit(); 

      when(homeCubit.editChat(newChat)).thenAnswer((_) { });

      GetIt.I.registerSingleton<ChatEditorCubit>(ChatEditorCubit());
      GetIt.I.registerSingleton<HomeCubit>(homeCubit);

      await tester.pumpWidget(
        CustomTheme(
          themeData: ThemeData.dark(),
          themeType: ThemeType.dark,
          bubbleAlignmentType: BubbleAlignmentType.left,
          fontSizeType: FontSizeType.medium,
          backgroundImage: null,
          child: MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => GetIt.I<ChatEditorCubit>(),
                ),
                BlocProvider(
                  create: (_) => homeCubit,
                ),
              ],
              child: const ChatEditorPage(),
            ),
          ),
        ),
      );

      final closeButton = find.ancestor(
        of: find.byIcon(Icons.close),
        matching: find.byType(FloatingActionButton),
      );
      expect(closeButton, findsOneWidget);

      final editField = find.byType(TextFormField).first;
      expect(editField, findsOneWidget);    

      await tester.enterText(editField, newName);
      await tester.pumpAndSettle();
      
      final saveButton = find.ancestor(
        of: find.byIcon(Icons.done),
        matching: find.byType(FloatingActionButton),
      );
      expect(saveButton, findsOneWidget);
    });
  });
}
