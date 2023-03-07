import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubits/events_cubit.dart';

import 'models/chat_model.dart';
import 'pages/home_page.dart';

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventsCubit(
        initState: EventsState(
          chats: [
            ChatModel(
              iconId: 1,
              title: 'Travel',
              id: UniqueKey(),
              date: DateTime.now(),
              cards: const [],
            ),
            ChatModel(
              iconId: 2,
              title: 'Family',
              id: UniqueKey(),
              date: DateTime.now(),
              cards: const [],
            ),
            ChatModel(
              iconId: 3,
              title: 'Sports',
              id: UniqueKey(),
              date: DateTime.now(),
              cards: const [],
            ),
          ],
        ),
      ),
      child: MaterialApp(
        title: 'Chat Journal',
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
        },
      ),
    );
  }
}
