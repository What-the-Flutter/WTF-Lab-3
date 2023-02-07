import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/my_chat_app.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';

class InitialBlocs extends StatelessWidget {
  final User user;

  const InitialBlocs({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MenuCubit(),
        ),
        BlocProvider(
          create: (_) => SettingCubit(user: user),
        ),
        BlocProvider(
          create: (_) => HomeCubit(user: user),
        ),
        BlocProvider(
          create: (_) => EventCubit(user: user),
        ),
        BlocProvider(
          create: (_) => TimelineCubit(user: user),
        ),
        BlocProvider(
          create: (_) => StatisticsCubit(user: user),
        )
      ],
      child: const MainApp(),
    );
  }
}
