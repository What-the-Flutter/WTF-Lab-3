import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/values/dimensions.dart';
import '../../../common/values/icons.dart';
import '../../../utils/strings.dart';
import '../data/repo/chat_repository.dart';
import '../domain/chat_model.dart';
import '../presentation/widget/chatter/chatter_card/chatter_card.dart';

class ChatVariation extends StatefulWidget {
  final ChatModel chat;
  final bool isEditMode;

  ChatVariation({
    super.key,
    required this.chat,
    required this.isEditMode,
  });

  @override
  State<StatefulWidget> createState() => _ChatVariationState();
}

class _ChatVariationState extends State<ChatVariation>
    with SingleTickerProviderStateMixin {
  final TextEditingController _chatTitleInputFieldController =
      TextEditingController();

  late final List<bool> _selectedIcon;

  var _chatTitle = '';
  var _chatIcon = Icons.chat;
  var _scale = 0.0;

  @override
  void initState() {
    super.initState();

    _selectedIcon = List.generate(possibleIcons.length, (index) {
      if (!widget.isEditMode && index == 0) {
        return true;
      } else {
        return false;
      }
    });

    if (widget.chat.chatTitle.isNotEmpty) {
      _chatTitle = widget.chat.chatTitle;
      _chatIcon = IconData(widget.chat.chatIcon, fontFamily: AppIcons.material);
    }

    _chatTitleInputFieldController.text = widget.chat.chatTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: _addChatButton(),
      body: Center(
        child: Column(
          children: [
            const Text(
              Strings.chatExample,
              style: TextStyle(fontSize: FontsSize.normal),
            ),
            _chatExample(),
            const SizedBox(height: Insets.appConstantSmall),
            _chatTitleInputField(),
            const SizedBox(height: Insets.appConstantSmall),
            _iconsBox(),
          ],
        ),
      ),
    );
  }

  Widget _chatTitleInputField() {
    return Padding(
      padding: const EdgeInsets.only(
        right: Insets.appConstantMedium,
        left: Insets.appConstantMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _chatTitleInputFieldController,
              maxLength: 15,
              autofocus: widget.isEditMode,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _scale = 1.0;
                    _chatTitle = value;
                  });
                } else {
                  setState(() {
                    _scale = 0.0;
                    _chatTitle = value;
                  });
                }
              },
              decoration: InputDecoration(
                label: const Text('Chat title'),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Radii.appConstant),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
                prefixIcon: const Icon(Icons.title),
                suffixIcon: _suffixIcon(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _suffixIcon() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _scale,
      child: Padding(
        padding: const EdgeInsets.only(right: Insets.small),
        child: IconButton(
          onPressed: () {
            setState(
              () {
                _scale = 0.0;
                _chatTitleInputFieldController.clear();
                _chatTitle = '';
              },
            );
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  Widget _chatExample() => ChatterCard(
        chat: ChatModel(
          id: widget.chat.id,
          chatTitle: _chatTitle,
          chatIcon: _chatIcon.codePoint,
          messages: IList(),
        ),
        isActionsVisible: widget.chat.chatTitle == '' ? false : true,
      );

  Widget _addChatButton() {
    final chats = RepositoryProvider.of<ChatRepository>(context).chats.value;

    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _scale,
      child: FloatingActionButton(
        onPressed: () {
          if (!widget.isEditMode) {
            RepositoryProvider.of<ChatRepository>(context).add(
              ChatModel(
                id: chats.isEmpty ? 0 : chats.last.id + 1,
                chatTitle: _chatTitleInputFieldController.text,
                chatIcon: _chatIcon.codePoint,
                messages: IList(),
              ),
            );
            Navigator.pop(context);
          } else {
            RepositoryProvider.of<ChatRepository>(context).update(
              widget.chat.copyWith(
                  chatTitle: _chatTitleInputFieldController.text,
                  chatIcon: _chatIcon.codePoint),
            );
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _iconsBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          right: Insets.appConstantMedium,
          left: Insets.appConstantMedium,
        ),
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            for (var index = 0; index < possibleIcons.length; index++)
              Padding(
                padding: const EdgeInsets.only(right: Insets.medium),
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
                        child: _selectCheckbox(index),
                      ),
                    ),
                    _selectableIcon(index),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _selectableIcon(int index) {
    return Container(
      width: 64.0,
      height: 64.0,
      child: IconButton(
        onPressed: () {
          setState(() {
            for (var i = 0; i < possibleIcons.length; i++) {
              if (_selectedIcon[i]) {
                _selectedIcon[i] = false;
                break;
              }
            }
            if (_selectedIcon[index]) {
              _selectedIcon[index] = false;
            } else {
              _selectedIcon[index] = true;
            }

            _chatIcon = IconData(
              possibleIcons[index],
              fontFamily: AppIcons.material,
            );
          });
        },
        icon: Icon(
          IconData(
            possibleIcons[index],
            fontFamily: AppIcons.material,
          ),
          size: IconsSize.large,
        ),
      ),
    );
  }

  Widget _selectCheckbox(int index) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.appConstant),
      ),
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide.none),
      activeColor: Theme.of(context).scaffoldBackgroundColor,
      checkColor: Theme.of(context).indicatorColor,
      value: _selectedIcon[index],
      onChanged: (value) {},
    );
  }
}
