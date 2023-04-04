import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/chat.dart';
import '../../utils/custom_theme.dart';
import '../home_page/home_cubit.dart';
import 'chat_editor_cubit.dart';
import 'widgets/chat_icons.dart';

class ChatEditorPage extends StatefulWidget {
  final Chat? sourceChat;

  const ChatEditorPage({
    super.key,
    this.sourceChat,
  });

  @override
  State<ChatEditorPage> createState() => _ChatEditorPageState();
}

class _ChatEditorPageState extends State<ChatEditorPage> {
  final _cubit = GetIt.I<ChatEditorCubit>();
  final _homeCubit = GetIt.I<HomeCubit>();

  void _saveChat({
    required BuildContext context,
    required String title,
    required int iconIndex,
  }) {
    if (title.isNotEmpty) {
      final chat = Chat(
        id: widget.sourceChat?.id,
        iconCode: ChatIcons.icons[iconIndex].codePoint,
        name: title,
        createdTime: widget.sourceChat?.createdTime ?? DateTime.now(),
        isPinned: false,
      );

      if (widget.sourceChat != null) {
        _homeCubit.editChat(chat);
      } else {
        _homeCubit.addChat(chat);
      }
    }

    _cubit.changeTitle('');

    Navigator.pop(context);
  }

  Widget _title() {
    final String titleText;
    if (widget.sourceChat == null) {
      titleText = 'Create a new page';
    } else {
      titleText = 'Edit Page';
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          titleText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _titleField() {
    final initialValue = widget.sourceChat?.name;
    if (initialValue != null) {
      _cubit.changeTitle(initialValue);
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: const InputDecoration(
          labelText: 'Name of the Page',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
        ),
        onChanged: _cubit.changeTitle,
      ),
    );
  }

  Widget _iconsView({
    required int iconIndex,
  }) {
    final icons = ChatIcons.icons;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: icons.length,
        itemBuilder: (_, index) => IconView(
          icon: icons[index],
          isSelected: index == iconIndex,
          size: 80,
          onTap: () => _cubit.selectIcon(index),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  Widget _floatingActionButton({
    required BuildContext context,
    required String title,
    required int iconIndex,
  }) {
    final icon = title.isNotEmpty ? Icons.done : Icons.close;
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: () => _saveChat(
        context: context,
        title: title,
        iconIndex: iconIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatEditorCubit, ChatEditorState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              _title(),
              _titleField(),
              Expanded(child: _iconsView(iconIndex: state.iconIndex)),
            ],
          ),
          floatingActionButton: _floatingActionButton(
            context: context,
            iconIndex: state.iconIndex,
            title: state.title,
          ),
        );
      },
    );
  }
}

class IconView extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? size;

  const IconView({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.size,
  });

  Widget _iconView(ColorScheme colorScheme) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Icon(
        icon,
        color: colorScheme.onBackground,
        size: 45.0,
      ),
    );
  }

  Widget _selectionIcon(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: colorScheme.background,
        ),
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Icon(
        Icons.done,
        color: colorScheme.onBackground,
        size: 25.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = CustomTheme.of(context).themeData.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(alignment: Alignment.bottomRight, children: [
        _iconView(colorScheme),
        if (isSelected) _selectionIcon(colorScheme),
      ]),
    );
  }
}
