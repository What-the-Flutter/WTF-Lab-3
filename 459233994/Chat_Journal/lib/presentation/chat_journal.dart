import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/biometric_auth_repository.dart';
import '../data/repos/chat_repository.dart';
import '../data/repos/event_repository.dart';
import '../data/repos/firebase_auth_repository.dart';
import '../data/repos/shared_preferences_repository.dart';
import '../data/repos/tag_repository.dart';
import '../data/services/database_service.dart';
import '../data/services/firebase_authentication_service.dart';
import '../data/services/shared_preferences.dart';
import 'screens/chat/chat_cubit.dart';
import 'screens/chat/chat_search_cubit..dart';
import 'screens/home/home_cubit.dart';
import 'screens/main_screen.dart';
import 'screens/settings/settings_cubit.dart';
import 'widgets/app_theme/app_theme_cubit.dart';
import 'widgets/events/event_dialog_cubit.dart';

class ChatJournal extends StatefulWidget {
  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  final FireBaseAuthService fireBaseAuthService = FireBaseAuthService();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  final DataBaseService dataBaseService = DataBaseService();
  late final FireBaseAuthRepository fireBaseAuthRepository;
  late final ChatRepositoryImpl chatRepository;
  late final EventRepositoryImpl eventRepository;
  late final TagRepositoryImpl tagRepository;
  late final SharedPreferencesRepository sharedPreferencesRepository;
  bool isBiometricAuthorized = false;

  @override
  void initState() {
    super.initState();
    fireBaseAuthRepository = FireBaseAuthRepository(fireBaseAuthService: fireBaseAuthService);
    chatRepository = ChatRepositoryImpl(dataBaseService: dataBaseService);
    eventRepository = EventRepositoryImpl(dataBaseService: dataBaseService);
    tagRepository = TagRepositoryImpl(dataBaseService: dataBaseService);
    sharedPreferencesRepository = SharedPreferencesRepository(
        sharedPreferencesService: sharedPreferencesService);
    isStatus();
  }

  void isStatus() async {
    final statusAuth = await BiometricAuthRepository.authenticateUser();
    setState(
      () {
        isBiometricAuthorized = statusAuth;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fireBaseAuthService.signInAnon();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            chatRepository: chatRepository,
          ),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => ChatCubit(
            eventRepository: eventRepository,
            tagRepository: tagRepository,
          ),
        ),
        BlocProvider<ChatSearchCubit>(
          create: (_) => ChatSearchCubit(),
        ),
        BlocProvider<EventDialogCubit>(
          create: (_) => EventDialogCubit(),
        ),
        BlocProvider<AppThemeCubit>(
          create: (_) => AppThemeCubit(
            sharedPreferencesService: sharedPreferencesService,
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(
            sharedPreferencesRepository: sharedPreferencesRepository,
          ),
        )
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
