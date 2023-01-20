// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/chat.dart';
import '../../provider/chat_provider.dart';
import '../../theme/colors.dart';
import '../../utils/icons.dart';
import '../widgets/add_chat_page/chat_icon.dart';

class AddChatPage extends StatefulWidget {
  final Chat? chat;
  final int? chatIndex;

  const AddChatPage({Key? key, this.chat, this.chatIndex}) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final _fieldText = TextEditingController();
  IconData _fabIcon = Icons.close;
  int _iconIndex = 0;
  final _icons = IconList.data;

  @override
  void initState() {
    super.initState();
    _fieldText.addListener(_changeFABIcon);

    if (widget.chat != null) {
      for (int i = 0; i < _icons.length; i++) {
        if (widget.chat?.iconData == _icons[i]) {
          _iconIndex = i;
          break;
        }
      }

      _fieldText.text = widget.chat?.title ?? '';
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
              local?.addNewChat ?? '',
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 10),
            _buildTextField(local),
            _buildIconsTable(),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.87),
        child: FloatingActionButton(
          onPressed: widget.chat == null ? _addNewChat : _editChat,
          child: Icon(_fabIcon),
        ),
      ),
    );
  }

  Widget _buildTextField(AppLocalizations? local) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _fieldText,
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        textInputAction: TextInputAction.newline,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          labelText: local?.addPageLabel ?? '',
          hintStyle: TextStyle(
            fontSize: 20,
            color: secondaryMessageTextColor,
          ),
        ),
        style: TextStyle(fontSize: 20, color: addTextColor),
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

  // Widget _firstIcon() {
  //   return Center(
  //     child: Text(
  //       _fieldText.text.isNotEmpty ? _fieldText.text.characters.first : 'N',
  //       style: const TextStyle(fontSize: 24),
  //     ),
  //   );
  // }

  void _changeFABIcon() {
    if (_fabIcon == Icons.close && _fieldText.text.isNotEmpty ||
        _fabIcon == Icons.check && _fieldText.text.isEmpty) {
      setState(() {
        _fabIcon = _fabIcon == Icons.close ? Icons.check : Icons.close;
      });
    }
  }

  void _addNewChat() {
    if (_fieldText.text.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).add(
        title: _fieldText.text,
        iconData: _icons[_iconIndex],
      );
    }

    Navigator.pop(context);
  }

  void _editChat() {
    if (_fieldText.text.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).edit(
        widget.chatIndex ?? 0,
        title: _fieldText.text,
        iconData: _icons[_iconIndex],
      );
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
