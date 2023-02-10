import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../common/themes/cubit/theme_cubit.dart';
import '../common/themes/themes/themes.dart';
import '../common/themes/widget/theme_scope.dart';
import '../common/values/dimensions.dart';
import '../common/widget/navigation_drawer/navigation_drawer_menu.dart';
import '../common/widget/theme_switcher.dart';
import 'chat_list/presentation/cubit/chatter_cubit.dart';
import 'chat_list/presentation/pages/chatter_new_page.dart';
import 'chat_list/presentation/widget/chatter/chatter_list/chatter_list.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndexPage = 0;
  bool _isFabVisible = true;

  @override
  void initState() {
    context.read<ThemeCubit>().state.isDarkMode
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
          );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(),
          drawer: const NavigationDrawerMenu(),
          floatingActionButton: _floatingActionButton(),
          bottomNavigationBar: _bottomNavigationBar(),
          body: _pagesContent(),
        );
      },
    );
  }

  Widget _pagesContent() {
    switch (_selectedIndexPage) {
      case 0:
        return _homeContent();
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _homeContent() {
    return Column(
      children: [
        const SizedBox(height: Insets.appConstantMedium),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                if (!_isFabVisible) setState(() => _isFabVisible = true);
              } else if (notification.direction == ScrollDirection.reverse) {
                if (_isFabVisible) setState(() => _isFabVisible = false);
              }

              return true;
            },
            child: HomeListView(),
          ),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
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
          gap: 5,
          tabBackgroundColor: Theme.of(context).primaryColor,
          tabs: const [
            GButton(icon: Icons.home_filled, text: 'Home'),
            GButton(icon: Icons.my_library_books_outlined, text: 'Daily'),
            GButton(icon: Icons.timeline, text: 'Timeline'),
            GButton(icon: Icons.explore, text: 'Explore')
          ],
          onTabChange: (index) => setState(() => _selectedIndexPage = index),
        ),
      ),
    );
  }

  Widget _floatingActionButton() => AnimatedSlide(
        curve: _isFabVisible ? Curves.fastOutSlowIn : Curves.decelerate,
        duration: const Duration(milliseconds: 400),
        offset: _isFabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: _isFabVisible ? 1 : 0,
          child: FloatingActionButton(
            backgroundColor: Color(ThemeScope.of(context).state.primaryColor),
            onPressed: _toNewChatScreen,
            child: const Icon(Icons.add),
          ),
        ),
      );

  void _toNewChatScreen() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NewChatScreen(),
        ),
      );

  @override
  void dispose() {
    context.read<ChatterCubit>().close();

    super.dispose();
  }
}
