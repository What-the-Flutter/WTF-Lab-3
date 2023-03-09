import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';

class AddChat extends StatefulWidget {
  final bool isEdited;
  final String currentChatId;
  final String chatName;

  AddChat(
      {required this.isEdited,
      required this.currentChatId,
      required this.chatName});

  @override
  State<AddChat> createState() => _AddChat();
}

class _AddChat extends State<AddChat> {
  late final AuthProvider _authProvider;
  late final TextEditingController _chatNameController;
  late final ChatProvider _chatProvider;
  late final String _currentUserId;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _chatProvider = context.read<ChatProvider>();
    _currentUserId = _authProvider.getUserFirebaseId()!;
    _chatNameController = TextEditingController();
    _chatNameController.text = widget.chatName;
  }

  void _addChat() {
    final _name = _chatNameController.text.toString();
    _chatProvider.addChat(_name, _currentUserId);
    Navigator.pop(context);
  }

  void _editChat() {
    final _name = _chatNameController.text.toString();
    _chatProvider.updateChat(_currentUserId, widget.currentChatId, _name);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                        size: 30, color: ColorConstants.greyColor),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    'Create New Chat',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextFormField(
                controller: _chatNameController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () => widget.isEdited ? _editChat() : _addChat(),
                label: const Text('add chat'),
                icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
