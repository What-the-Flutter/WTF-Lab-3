import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/my_chat_app.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/bottom_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MenuCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (_) => EventCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
