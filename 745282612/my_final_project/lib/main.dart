import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/my_chat_app.dart';
import 'package:my_final_project/services/auth.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = await AuthServise().getOrCreateUser();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MenuCubit(user: user),
        ),
        BlocProvider(
          create: (_) => HomeCubit(user: user),
        ),
        BlocProvider(
          create: (_) => EventCubit(user: user),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
