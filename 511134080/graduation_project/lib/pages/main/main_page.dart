import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';
import '../../widgets/drawer.dart';
import '../home/home_page.dart';
import '../timeline/timeline_page.dart';
import 'main_page_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().startLoading();
  }

  Widget _body(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 2:
        return TimelinePage(
          context: context,
        );
      default:
        throw Exception('Invalid index!');
    }
  }

  BottomNavigationBar _bottomNavigationBar(
          BuildContext context, MainPageState state) =>
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
            ),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          )
        ],
        selectedItemColor: Colors.deepPurple,
        currentIndex: state.selectedIndex,
        onTap: context.read<MainPageCubit>().changeSelectedIndex,
      );

  Widget _homeAnimation() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 128,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Chat Journal',
                  textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 48,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                  speed: const Duration(
                    milliseconds: 300,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            Lottie.asset(
              homeAnimationLottie,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) => Scaffold(
          drawer: state.isLoaded ? null : const CustomDrawer(),
          body: state.isLoaded
              ? _homeAnimation()
              : _body(context, state.selectedIndex),
          bottomNavigationBar:
              state.isLoaded ? null : _bottomNavigationBar(context, state),
        ),
      );
}
