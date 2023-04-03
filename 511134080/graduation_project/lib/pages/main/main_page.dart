import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<MainPageCubit>().authenticateLocal();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MainPageCubit>().logout();
    super.dispose();
  }

  Widget _body(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 2:
        return const TimelinePage();
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

  Widget _authenticatedScaffold(BuildContext context, MainPageState state) =>
      Scaffold(
        drawer: const CustomDrawer(),
        body: _body(context, state.selectedIndex),
        bottomNavigationBar: _bottomNavigationBar(context, state),
      );

  Widget _nonAuthenticatedScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Authentication',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  bottom: 48,
                ),
                child: Text(
                  'Waiting for authentication...',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                ),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MainPageCubit, MainPageState>(
        builder: (_, state) => state.isAuthenticated
            ? _authenticatedScaffold(context, state)
            : _nonAuthenticatedScaffold(context),
      );
}
