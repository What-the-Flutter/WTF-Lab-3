import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubits/chat_cubit.dart';
import '../models/chat.dart';

class AddChatPage extends StatefulWidget {
  AddChatPage({super.key, required this.chat});

  final Chat? chat;

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final _textEditingController = TextEditingController();
  int _selectedIndex = -1;

  int _findIcon() {
    for (var i = 0; i < icons.length; ++i) {
      if (icons[i] == widget.chat!.icon) {
        return i;
      }
    }
    return -1;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.chat?.name ?? '';
    _selectedIndex = widget.chat != null ? _findIcon() : -1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: 30,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 90, 30, 20),
        child: Column(
          children: [
            Text(
              widget.chat == null ? 'Create a new Page' : 'Edit Page',
              style: style,
            ),
            const SizedBox(height: 38),
            TextField(
              autofocus: true,
              onChanged: (str) {
                setState(() {});
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                fillColor: theme.colorScheme.background,
                hintText: 'Enter name',
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            icon: icons[index],
                          ),
                        ),
                        Icon(
                          _selectedIndex == index ? Icons.check : null,
                        )
                      ],
                    ),
                  );
                },
                itemCount: icons.length,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          backgroundColor:
              (_selectedIndex == -1 || _textEditingController.text.isEmpty)
                  ? Colors.grey.shade700
                  : Colors.green,
          onPressed: () {
            if (_selectedIndex != -1 &&
                _textEditingController.text.isNotEmpty) {
              final chatKey = widget.chat?.key ?? UniqueKey();
              final chat = Chat(
                name: _textEditingController.text,
                icon: icons[_selectedIndex],
                key: chatKey,
              );
              context.read<ChatsCubit>().update(chat);
              Navigator.pop(context);
            }
          },
          tooltip: 'Add',
          child: const Icon(Icons.done),
        ),
      ),
    );
  }
}
