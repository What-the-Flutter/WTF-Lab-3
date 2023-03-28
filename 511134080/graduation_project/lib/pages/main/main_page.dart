import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/drawer.dart';
import '../home/home_page.dart';
import '../timaline/timeline_page.dart';
import 'main_page_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) => Scaffold(
          drawer: const CustomDrawer(),
          body: _body(context, state.selectedIndex),
          bottomNavigationBar: _bottomNavigationBar(context, state),
        ),
      );
}
