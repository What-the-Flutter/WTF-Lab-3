import 'dart:io';

import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../lifecycle_event_handler.dart';
import '../core/util/resources/themes.dart';
import 'cubit/theme/theme_cubit.dart';
import 'widget/general/theme_switcher.dart';
import 'widget/main/animated_main_title.dart';
import 'widget/main/bottom_navigation_gnav.dart';
import 'widget/main/clear_filter.dart';
import 'widget/main/fab_button.dart';
import 'widget/main/filter_action.dart';
import 'widget/main/start_page_body.dart';
import 'widget/main/statistic/statistic_scope.dart';
import 'widget/theme/theme_scope.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        pausedCallback: StatisticScope.of(context).dispatchAction,
        resumedCallback: StatisticScope.of(context).updateEntryTime,
      ),
    );

    _systemNavBarColor();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            extendBody: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              title: const AnimatedMainTitle(),
              centerTitle: false,
              actions: [
                const ClearFilter(),
                const FilterAction(),
                const ThemeSwitcher(),
              ],
            ),
            floatingActionButton: const FabButton(),
            bottomNavigationBar: const BottomNavigationGNav(),
            body: const StartPageBody(),
          );
        },
      ),
      onWillPop: () async {
        await _handleSystemBackButton();
        return await true;
      },
    );
  }

  Future<void> _handleSystemBackButton() async {
    if (Platform.isAndroid) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      await FlutterAppMinimizer.minimize();
    } else {
      exit(0);
    }
  }

  void _systemNavBarColor() {
    Future.delayed(
      Duration.zero,
          () => context.read<ThemeCubit>().state.isDarkMode
          ? SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(AppColors.primaryDark),
        ),
      )
          : SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Color(
            ThemeScope.of(context).state.primaryColor,
          ),
        ),
      ),
    );
  }
}
