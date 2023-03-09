import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';

class AddChat extends StatefulWidget {
  final bool isEdited;
  final String currentChatId;
  final String chatName;
  AddChat({required this.isEdited, required this.currentChatId, required this.chatName});

  @override
  State<AddChat> createState() => _AddChat();
}

class _AddChat extends State<AddChat> {
  late AuthProvider authProvider;
  late TextEditingController _chatNameController;
  late ChatProvider chatProvider;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    chatProvider = context.read<ChatProvider>();
    currentUserId = authProvider.getUserFirebaseId()!;
    _chatNameController = TextEditingController();
    _chatNameController.text = widget.chatName;
  }

  void addChat() {
    var name = _chatNameController.text.toString();
    chatProvider.addChat(name, currentUserId);
    Navigator.pop(context);
  }

  void editChat() {
    var name = _chatNameController.text.toString();
    chatProvider.updateChat(currentUserId, widget.currentChatId, name);
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
                onPressed: ()=>{ widget.isEdited ? editChat() : addChat()},
                label: const Text('add chat'),
                icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
