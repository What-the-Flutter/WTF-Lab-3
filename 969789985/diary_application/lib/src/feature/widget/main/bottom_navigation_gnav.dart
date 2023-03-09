import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/util/resources/dimensions.dart';
import '../../cubit/main/start_screen_cubit.dart';
import '../theme/theme_scope.dart';
import 'scope/main_scope.dart';

class BottomNavigationGNav extends StatelessWidget {
  const BottomNavigationGNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          height: state.gNavVisible ? 95.0 : 0.0,
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: Color(ThemeScope.of(context).state.primaryColor),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Radii.appConstant),
              topRight: Radius.circular(Radii.appConstant),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.appConstantSmall,
              vertical: Insets.appConstantSmall,
            ),
            child: GNav(
              selectedIndex: state.pageIndex,
              gap: 5,
              tabBackgroundColor: Theme.of(context).primaryColor,
              tabs: const [
                GButton(icon: Icons.home_filled, text: 'Home'),
                GButton(icon: Icons.view_timeline, text: 'Timeline'),
                GButton(icon: Icons.graphic_eq, text: 'Statistic'),
                GButton(icon: Icons.settings, text: 'Settings'),
              ],
              onTabChange: (index) {
                StartScreenScope.of(context).pageIndex = index;
                StartScreenScope.of(context).hashtag = '';
                if (index == 0) {
                  StartScreenScope.of(context).fabVisible = true;
                } else {
                  StartScreenScope.of(context).fabVisible = false;
                }
              },
            ),
          ),
        );
      },
    );
  }
}
