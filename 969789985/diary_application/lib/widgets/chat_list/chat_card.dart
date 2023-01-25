import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/providers/chat_list_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../basic/utils/strings.dart';
import '../../ui/screens/chat/chat_screen.dart';
import '../../ui/screens/chat/edit_chat_screen.dart';
import '../../ui/utils/dimensions.dart';
import '../../ui/utils/icons.dart';
import '../common/custom_dialog.dart';

class ChatCard extends StatefulWidget {
  final ChatListProvider? provider;
  final ChatModel chat;
  final bool isActionsVisible;

  ChatCard({
    super.key,
    required this.provider,
    required this.chat,
    required this.isActionsVisible,
  });

  @override
  State<StatefulWidget> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.small,
        right: Insets.small,
        bottom: Insets.small,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.applicationConstant),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          onPressed: widget.isActionsVisible ? _navigateToChatPage : null,
          onLongPress: () => widget.isActionsVisible
              ? widget.chat.isArchive
                  ? null
                  : _showChatBottomSheet(context)
              : null,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Insets.applicationConstantSmall,
              right: Insets.applicationConstantSmall,
              top: Insets.applicationConstantLarge,
              bottom: Insets.applicationConstantLarge,
            ),
            child: _chatContent(),
          ),
        ),
      ),
    );
  }

  Widget _chatContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconData(widget.chat.chatIcon, fontFamily: AppIcons.material),
              size: IconsSize.extraLarge,
            ),
            const SizedBox(width: Insets.applicationConstantMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.normal),
                ),
                SizedBox(
                  width: 150.0,
                  child: Text(
                    widget.chat.lastMessage == null
                        ? 'Start this chat...'
                        : widget.chat.lastMessage!.messageText,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).hintColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.chat.creationDate.timeJmFormat(),
                  style: const TextStyle(fontSize: FontsSize.standard),
                ),
                _animatedPinnedIcon(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _animatedPinnedIcon() => AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: widget.chat.isPinned ? 1.0 : 0.0,
        child: const Icon(Icons.attach_file),
      );

  void _showChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Insets.applicationConstantMedium),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.applicationConstant),
              color: Theme.of(context).primaryColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _informationButton(),
                  _pinButton(),
                  _editButton(),
                  _deleteButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _informationButton() => Padding(
        padding: const EdgeInsets.all(Insets.applicationConstantSmall),
        child: MaterialButton(
          onPressed: _informationDialog,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Row(
              children: const [
                Icon(Icons.info_outline),
                SizedBox(width: Insets.applicationConstantSmall),
                Text('Information'),
              ],
            ),
          ),
        ),
      );

  void _informationDialog() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        dialogTitle: Strings.chatInformationTitle,
        dialogDescription: _dialogDescription(),
        completeAction: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          Navigator.pop(context);
        },
        cancelVisible: false,
      ),
    );
  }

  Widget _dialogDescription() {
    final creationDate = widget.chat.creationDate.dateYMMMDFormat();
    final creationTime = widget.chat.creationDate.timeJmFormat();
    String? latestMessageDate;
    String? latestMessageTime;

    if (widget.chat.messages.isNotEmpty) {
      latestMessageDate = widget.chat.messages.last.sendDate.dateYMMMDFormat();
      latestMessageTime = widget.chat.messages.last.sendDate.timeJmFormat();
    }

    return Container(
      height: widget.chat.messages.isEmpty ? 158.0 : 184.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Insets.none),
            child: Row(
              children: [
                Icon(
                  IconData(widget.chat.chatIcon, fontFamily: AppIcons.material),
                  size: IconsSize.extraLarge,
                ),
                const SizedBox(width: Insets.medium),
                Text(
                  widget.chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.extraLarge),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.large),
          Text(
            'Created at\n$creationDate $creationTime',
            style: const TextStyle(fontSize: FontsSize.normal),
          ),
          const SizedBox(height: Insets.large),
          Text(
            latestMessageDate != null
                ? 'Last message at\n$latestMessageDate $latestMessageTime'
                : 'Chat is currently empty',
            style: const TextStyle(fontSize: FontsSize.normal),
          ),
        ],
      ),
    );
  }

  Widget _pinButton() => Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: MaterialButton(
          onPressed: () {
            widget.provider!.update(
              widget.chat.copyWith(isPinned: !widget.chat.isPinned),
            );
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Row(
              children: const [
                Icon(Icons.attach_file),
                SizedBox(width: Insets.applicationConstantSmall),
                Text('Pin/Unpin chat'),
              ],
            ),
          ),
        ),
      );

  Widget _editButton() => Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: MaterialButton(
          onPressed: _navigateToEditPage,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Row(
              children: const [
                Icon(Icons.edit),
                SizedBox(width: Insets.applicationConstantSmall),
                Text('Edit chat'),
              ],
            ),
          ),
        ),
      );

  Widget _deleteButton() => Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: MaterialButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => CustomDialog(
              dialogTitle: Strings.deleteChatTitle,
              dialogDescription: const Text(Strings.deleteChatDescription),
              completeAction: () {
                widget.provider!.removeChat(widget.chat);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              cancelVisible: true,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Insets.medium),
            child: Row(
              children: const [
                Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                SizedBox(width: Insets.applicationConstantSmall),
                Text(
                  'Delete chat',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );

  void _navigateToChatPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(chat: widget.chat),
      ),
    );
  }

  void _navigateToEditPage() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditChatScreen(chat: widget.chat),
        ),
      );
}
