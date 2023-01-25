import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../basic/providers/chat_list_provider.dart';
import '../../basic/themes/app_theme.dart';
import '../../widgets/chat_list/chat_list_view.dart';
import '../../widgets/common/navigation_drawer.dart';
import '../../widgets/common/theme_switcher.dart';
import '../utils/dimensions.dart';
import '../utils/themes.dart';
import 'chat/new_chat_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  int _selectedIndexPage = 0;
  bool _isFabVisible = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final appTheme = ThemeChanger.of(context).appTheme;

      appTheme.isDarkMode
          ? SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor: Color(AppColors.primaryDark),
              ),
            )
          : SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor: Color(AppColors.primaryLight),
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            actions: [
              ThemeSwitcher(),
            ],
          ),
          drawer: const NavigationDrawer(),
          floatingActionButton: _floatingActionButton(),
          bottomNavigationBar: _bottomNavigationBar(),
          body: _pagesContent(provider),
        );
      },
    );
  }

  Widget _pagesContent(ChatListProvider provider) {
    switch (_selectedIndexPage) {
      case 0:
        return _homeContent(provider);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _homeContent(ChatListProvider provider) {
    return Column(
      children: [
        const SizedBox(height: Insets.applicationConstantMedium),
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
            child: HomeListView(
              chatsList: provider.repository.chats
                  .sort((a, b) => b.isPinned.compareTo(a.isPinned)),
              provider: provider,
              searchTextEditingController: _searchTextEditingController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Radii.applicationConstant),
          topRight: Radius.circular(Radii.applicationConstant),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.applicationConstantSmall,
          vertical: Insets.applicationConstantSmall,
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
          onTabChange: (index) {
            setState(() => _selectedIndexPage = index);
          },
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
}
