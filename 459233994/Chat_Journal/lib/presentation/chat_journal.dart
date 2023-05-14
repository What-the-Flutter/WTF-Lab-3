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
import 'screens/statistics/statistics_cubit.dart';
import 'screens/time_line/time_line_cubit.dart';
import 'widgets/app_theme/app_theme_cubit.dart';
import 'widgets/app_theme/app_theme_state.dart';
import 'widgets/app_theme/inherited_theme.dart';
import 'widgets/app_theme/theme.dart';
import 'widgets/events/event_dialog_cubit.dart';

class ChatJournal extends StatefulWidget {
  @override
  State<ChatJournal> createState() => _ChatJournalState();
}

class _ChatJournalState extends State<ChatJournal> {
  final FireBaseAuthService _fireBaseAuthService = FireBaseAuthService();
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();
  final DataBaseService _dataBaseService = DataBaseService();
  late final FireBaseAuthRepository _fireBaseAuthRepository;
  late final ChatRepositoryImpl _chatRepository;
  late final EventRepositoryImpl _eventRepository;
  late final TagRepositoryImpl _tagRepository;
  late final SharedPreferencesRepository _sharedPreferencesRepository;
  bool _isBiometricAuthorized = false;

  @override
  void initState() {
    super.initState();
    _fireBaseAuthRepository =
        FireBaseAuthRepository(fireBaseAuthService: _fireBaseAuthService);
    _chatRepository = ChatRepositoryImpl(dataBaseService: _dataBaseService);
    _eventRepository = EventRepositoryImpl(dataBaseService: _dataBaseService);
    _tagRepository = TagRepositoryImpl(dataBaseService: _dataBaseService);
    _sharedPreferencesRepository = SharedPreferencesRepository(
        sharedPreferencesService: _sharedPreferencesService);
    isStatus();
  }

  void isStatus() async {
    final statusAuth = await BiometricAuthRepository.authenticateUser();
    setState(
      () {
        _isBiometricAuthorized = statusAuth;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _fireBaseAuthService.signInAnon();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            chatRepository: _chatRepository,
          ),
        ),
        BlocProvider<ChatCubit>(
          create: (_) => ChatCubit(
            eventRepository: _eventRepository,
            tagRepository: _tagRepository,
          ),
        ),
        BlocProvider<ChatSearchCubit>(
          create: (_) => ChatSearchCubit(),
        ),
        BlocProvider<EventDialogCubit>(
          create: (_) => EventDialogCubit(),
        ),
        BlocProvider<TimeLineCubit>(
          create: (_) => TimeLineCubit(
            eventRepository: _eventRepository,
          ),
        ),
        BlocProvider<StatisticsCubit>(
          create: (_) => StatisticsCubit(
            eventRepository: _eventRepository,
          ),
        ),
        BlocProvider<AppThemeCubit>(
          create: (_) => AppThemeCubit(
            sharedPreferencesRepository: _sharedPreferencesRepository,
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(
            sharedPreferencesRepository: _sharedPreferencesRepository,
          ),
        )
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return InheritedAppTheme(
            themeData: ReadContext(context).read<AppThemeCubit>().state.theme ==
                    Themes.light
                ? CustomTheme.lightTheme
                : CustomTheme.darkTheme,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              home: _isBiometricAuthorized
                  ? const MainScreen()
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
