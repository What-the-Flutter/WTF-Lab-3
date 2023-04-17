import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/app_theme/app_theme_cubit.dart';
import '../../widgets/app_theme/inherited_theme.dart';
import '../../widgets/home/chat_list.dart';
import '../../widgets/home/questionnaire_button.dart';
import '../add_chat.dart';
import '../settings/settings.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class Home extends StatefulWidget {
  final String title = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: QuestionnaireButton(),
                ),
                ChatList(
                  pages: state.chats,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                InheritedAppTheme.of(context)!.themeData.actionColor,
            onPressed: () => _addPage(context),
            child: Icon(
              Icons.add,
              color: InheritedAppTheme.of(context)!.themeData.iconColor,
            ),
          ),
          drawer: _drawer(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: InheritedAppTheme.of(context)!.themeData.themeColor,
      iconTheme: IconThemeData(
        color: InheritedAppTheme.of(context)!.themeData.keyColor,
      ),
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            color: InheritedAppTheme.of(context)!.themeData.keyColor,
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 1.0 * 3.14159,
                  child: child,
                );
              },
              child: Icon(
                Icons.contrast,
                color: InheritedAppTheme.of(context)!.themeData.keyColor,
              ),
            ),
            onTap: () {
              setState(() {
                ReadContext(context).read<AppThemeCubit>().changeTheme();
                _themeIconTapHandler();
              });
            },
          ),
        )
      ],
    );
  }

  Widget _drawer() {
    return Drawer(
      backgroundColor: InheritedAppTheme.of(context)!.themeData.auxiliaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: InheritedAppTheme.of(context)!.themeData.themeColor,
            ),
            child: Text(
              'Chat Journal',
              style: TextStyle(
                  color: InheritedAppTheme.of(context)!.themeData.textColor),
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                  color: InheritedAppTheme.of(context)!.themeData.textColor),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Share',
              style: TextStyle(
                  color: InheritedAppTheme.of(context)!.themeData.textColor),
            ),
            onTap: () {
              Share.share(
                'Chat journal!',
                subject: 'Download the App',
              );
            },
          ),
        ],
      ),
    );
  }

  void _themeIconTapHandler() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Future<void> _addPage(BuildContext context) async {
    final newChat = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChatScreen(),
      ),
    );
    if (newChat != null) {
      ReadContext(context).read<HomeCubit>().addChat(chat: newChat);
    }
  }
}
