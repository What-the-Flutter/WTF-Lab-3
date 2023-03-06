import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/chat/chat_cubit.dart';
import 'presentation/screens/chat/chat_search_cubit..dart';
import 'presentation/screens/home/home_cubit.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/widgets/app_theme/app_theme.dart';
import 'presentation/widgets/events/event_dialog_cubit.dart';

void main() {
  runApp(const ChatJournal());
}

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AppTheme(
      child: MultiBlocProvider(
        providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
            ),
          BlocProvider<ChatCubit>(
            create: (context) => ChatCubit(),
          ),
          BlocProvider<ChatSearchCubit>(
            create: (context) => ChatSearchCubit(),
          ),
          BlocProvider<EventDialogCubit>(
            create:  (context) => EventDialogCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}