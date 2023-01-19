import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/models/message_model.dart';
import '../../basic/utils/chat_icons.dart';
import '../../widgets/chat_list/chat_card.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const _NewChatBody(),
      );
}

class _NewChatBody extends StatefulWidget {
  const _NewChatBody({super.key});

  @override
  State<StatefulWidget> createState() => _NewChatBodyState();
}

class _NewChatBodyState extends State<_NewChatBody>
    with SingleTickerProviderStateMixin {
  final TextEditingController _chatTitleInputFieldController =
      TextEditingController();

  late final List<bool> _selectedIcon;

  var _chatTitle = '';
  var _chatIcon = Icons.chat;

  @override
  void initState() {
    super.initState();

    _selectedIcon = List.generate(chatIcons.length, (index) {
      if (index == 0) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            _chatTitleInputField(),
            const SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: _iconsBox(),
              ),
            ),
            const Text(
              'Your chat:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 5.0),
            _chatExample(),
          ],
        ),
      );

  Widget _chatTitleInputField() => Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _chatTitleInputFieldController,
                maxLength: 15,
                onChanged: (value) {
                  setState(() => _chatTitle = value);
                },
                decoration: InputDecoration(
                  label: const Text('Chat title'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.title),
                  suffixIcon: AnimatedSlide(
                    duration: const Duration(milliseconds: 150),
                    offset: _chatTitleInputFieldController.text.isEmpty
                        ? const Offset(0, -0.2)
                        : Offset.zero,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity:
                            _chatTitleInputFieldController.text.isEmpty ? 0 : 1,
                        child: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _chatTitleInputFieldController.clear();
                                _chatTitle = '';
                              },
                            );
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _chatExample() => ChatCard(
        chat: ChatModel(
            id: 0,
            chatTitle: _chatTitle,
            chatIcon: _chatIcon,
            messages: <MessageModel>[].lock),
        isActionsVisible: false,
      );

  Widget _iconsBox() => GridView.count(
        crossAxisCount: 6,
        children: [
          for (var i = 0; i < chatIcons.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        left: 30.0,
                      ),
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide.none),
                        activeColor: Theme.of(context).scaffoldBackgroundColor,
                        checkColor: Colors.black,
                        value: _selectedIcon[i],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    width: 64.0,
                    height: 64.0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          for (var i = 0; i < chatIcons.length; i++) {
                            if (_selectedIcon[i]) {
                              _selectedIcon[i] = false;
                              break;
                            }
                          }
                          if (_selectedIcon[i]) {
                            _selectedIcon[i] = false;
                          } else {
                            _selectedIcon[i] = true;
                          }

                          _chatIcon = chatIcons[i];
                        });
                      },
                      icon: Icon(
                        chatIcons[i],
                        size: 36.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
}
