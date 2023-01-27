// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/chat.dart';
import '../../provider/chat_provider.dart';
import '../../utils/icons.dart';
import '../../utils/utils.dart';
import '../widgets/add_chat_page/add_chat_keyboard.dart';
import '../widgets/add_chat_page/chat_icon.dart';

class AddChatPage extends StatefulWidget {
  final Chat? chat;
  final int? chatIndex;

  const AddChatPage({Key? key, this.chat, this.chatIndex}) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  IconData _fabIcon = Icons.close;
  int _iconIndex = 0;
  final _icons = IconList.data;
  late final TextEditingController _fieldText;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _fieldText = TextEditingController();
    _fieldText.addListener(_changeFABIcon);

    if (widget.chat != null) {
      for (int i = 0; i < _icons.length; i++) {
        if (widget.chat?.iconData == _icons[i]) {
          _iconIndex = i;
          break;
        }
      }

      _fieldText.text = widget.chat?.title ?? '';
      _isEditMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 70),
            Text(
              !_isEditMode ? local?.addNewChat ?? '' : local?.editChat ?? '',
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 10),
            AddChatKeyboard(
              fieldText: _fieldText,
              pageLabel: local?.addPageLabel ?? '',
            ),
            _buildIconsTable(),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.87),
        child: FloatingActionButton(
          onPressed: _addOrEditChat,
          child: Icon(_fabIcon),
        ),
      ),
    );
  }

  Widget _buildIconsTable() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 40,
          crossAxisSpacing: 40,
        ),
        itemCount: _icons.length,
        itemBuilder: (_, index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: ChatIcon(
              child: Icon(_icons[index]),
              index: index,
              pageIndex: _iconIndex,
            ),
            onTap: () {
              setState(() => _iconIndex = index);
            },
          );
        },
      ),
    );
  }

  void _changeFABIcon() {
    if (_fabIcon == Icons.close && _fieldText.text.isNotEmpty ||
        _fabIcon == Icons.check && _fieldText.text.isEmpty) {
      setState(() {
        _fabIcon = _fabIcon == Icons.close ? Icons.check : Icons.close;
      });
    }
  }

  void _addOrEditChat() {
    if (_fieldText.text.isNotEmpty) {
      final provider = Provider.of<ChatProvider>(context, listen: false);
      if (widget.chat == null) {
        provider.add(
          title: _fieldText.text,
          iconData: _icons[_iconIndex],
        );
      } else {
        provider.edit(
          widget.chatIndex ?? 0,
          title: _fieldText.text,
          iconData: _icons[_iconIndex],
        );
      }
    }

    closePage(context);
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
