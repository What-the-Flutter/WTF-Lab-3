import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_theme/app_theme_cubit.dart';
import '../../widgets/home/chat_list.dart';
import '../../widgets/home/questionnaire_button.dart';
import '../../widgets/main_screen_section.dart';
import '../add_chat.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class Home extends MainScreenSection {
  @override
  final String title = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .backgroundColor,
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
            backgroundColor: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .actionColor,
            onPressed: () => {
              _addPage(context),
            },
            child: Icon(
              Icons.add,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .iconColor,
            ),
          ),
        );
      },
    );
  }
}
