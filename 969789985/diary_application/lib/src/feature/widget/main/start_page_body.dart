import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/main/start_screen_cubit.dart';
import 'home/home_body.dart';
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
          case 2:
            return const TimelineBody();
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
