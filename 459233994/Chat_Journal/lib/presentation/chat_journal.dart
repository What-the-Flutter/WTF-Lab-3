import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/chat_repository.dart';
import '../data/repos/event_repository.dart';
import '../data/services/BiometricAuthService.dart';
import '../data/services/firebase_authentication_service.dart';
import '../data/services/shared_preferences.dart';
import 'screens/chat/chat_cubit.dart';
import 'screens/chat/chat_search_cubit..dart';
import 'screens/home/home_cubit.dart';
import 'screens/main_screen.dart';
import 'widgets/app_theme/app_theme_cubit.dart';
import 'widgets/events/event_dialog_cubit.dart';

class ChatJournal extends StatefulWidget {
  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  final FireBaseAuthService authService = FireBaseAuthService();
  final ChatRepositoryImpl chatRepository = ChatRepositoryImpl();
  final EventRepositoryImpl eventRepository = EventRepositoryImpl();
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  bool isBiometricAuthorized = false;

  @override
  void initState() {
    super.initState();
    isStatus();
  }

  void isStatus() async {
    final statusAuth = await BiometricAuthService.authenticateUser();
    setState(
      () {
        isBiometricAuthorized = statusAuth;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    authService.signInAnon();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(chatRepository: chatRepository),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => ChatCubit(eventRepository: eventRepository),
        ),
        BlocProvider<ChatSearchCubit>(
          create: (_) => ChatSearchCubit(),
        ),
        BlocProvider<EventDialogCubit>(
          create: (_) => EventDialogCubit(),
        ),
        BlocProvider<AppThemeCubit>(
          create: (_) => AppThemeCubit(sharedPreferencesService: sharedPreferencesService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: !isBiometricAuthorized
            ? const MainScreen()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
