import 'package:cool_chat_journal/data/models/chat.dart';
import 'package:cool_chat_journal/presentation/filters_page/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PagesTab', () {
    final testedChats = [
      Chat(
        iconCode: 42,
        name: 'Random name 1',
        createdTime: DateTime.now(),
        isPinned: true,
      ),
      Chat(
        iconCode: 43,
        name: 'Random name 2',
        createdTime: DateTime.now(),
        isPinned: true,
      ),
      Chat(
        iconCode: 44,
        name: 'Random name 3',
        createdTime: DateTime.now(),
        isPinned: true,
      ),
    ];


    testWidgets('welcome message when selectedChats is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PagesTab(
              chats: testedChats,
              selectedChats: [],
              ignoreSelected: true,
              changeIgnoreSelected: (_) {},
              changeChatSelection: (_) {},
            ),
          ),
        ),
      );

      final textFinder =
          find.text('Tap to select a page you want to include to the filter. '
              'All pages are included by default');

      expect(textFinder, findsOneWidget);
    });

    testWidgets(
      'welcome message when selectedChats is not empty and ignored',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PagesTab(
                chats: testedChats,
                selectedChats: [
                  Chat(
                    iconCode: 42,
                    name: 'Random name 1',
                    createdTime: DateTime.now(),
                    isPinned: true,
                  ),
                  Chat(
                    iconCode: 44,
                    name: 'Random name 3',
                    createdTime: DateTime.now(),
                    isPinned: true,
                  ),
                ],
                ignoreSelected: true,
                changeIgnoreSelected: (_) {},
                changeChatSelection: (_) {},
              ),
            ),
          ),
        );

        final textFinder = find.text('2 page(s) Ignored');

        expect(textFinder, findsOneWidget);
      },
    );

    testWidgets(
      'welcome message when selectedChats is not empty and included',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PagesTab(
                chats: testedChats,
                selectedChats: [
                  Chat(
                    iconCode: 42,
                    name: 'Random name 1',
                    createdTime: DateTime.now(),
                    isPinned: true,
                  ),
                  Chat(
                    iconCode: 44,
                    name: 'Random name 3',
                    createdTime: DateTime.now(),
                    isPinned: true,
                  ),
                ],
                ignoreSelected: false,
                changeIgnoreSelected: (_) {},
                changeChatSelection: (_) {},
              ),
            ),
          ),
        );

        final textFinder = find.text('2 page(s) Included');

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
