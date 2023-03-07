import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/main/start_screen_cubit.dart';
import '../settings/main_section/settings_body.dart';
import 'home/home_body.dart';
import 'statistic/statistic_body.dart';
import 'timeline/timeline_body.dart';

class StartPageBody extends StatelessWidget {
  const StartPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, state) {
        switch (state.pageIndex) {
          case 0:
            return const HomeBody();
          case 1:
            return const TimelineBody();
          case 2:
            return const StatisticBody();
          case 3:
            return const SettingsBody();
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
