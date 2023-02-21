import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/app_theme/inherited_app_theme.dart';
import '../../widgets/main_screen_section.dart';
import '../add_chat.dart';
import 'chat_list.dart';
import 'home_cubit.dart';
import 'home_state.dart';
import 'questionnaire_button.dart';

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
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor:
                InheritedAppTheme.of(context)?.getTheme.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: QuestionnaireButton(),
                  ),
                  ChatList(
                    pages: state.chats,
                    editFunc: ReadContext(context).read<HomeCubit>().editChat,
                    deleteFunc: ReadContext(context).read<HomeCubit>().deleteChat,
                    pinFunc: ReadContext(context).read<HomeCubit>().pinChat,
                    getChatsFunc: ReadContext(context).read<HomeCubit>().getChats,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor:
                  InheritedAppTheme.of(context)?.getTheme.actionColor,
              onPressed: () => {
                _addPage(context),
              },
              child: Icon(
                Icons.add,
                color: InheritedAppTheme.of(context)?.getTheme.iconColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
