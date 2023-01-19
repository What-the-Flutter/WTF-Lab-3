import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../provider/chat_provider.dart';
import '../../theme/colors.dart';
import '../tools/event_action.dart';
import '../widgets/attach_dialog.dart';
import '../widgets/event_box.dart';
import '../widgets/info_box.dart';
import '../widgets/keyboard_icon.dart';
import '../widgets/tool_menu_icon.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final _fieldText = TextEditingController();
  final _bookMark = Icons.bookmark_border_outlined;
  AppLocalizations? _local;
  late EventAction _action;

  @override
  void initState() {
    super.initState();
    _action = EventAction(widget.chat, _fieldText);
  }

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: Scaffold(
        appBar: _action.selectedMode ? _buildSelectedAppBar() : _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.chat.events.isNotEmpty
                  ? _buildMessageList(size)
                  : InfoBox(size: size, mainTitle: widget.chat.title),
              _getInputBox(size),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.chat.title),
      centerTitle: true,
      actions: <Widget>[
        ToolMenuIcon(
          icon: Icons.search,
          onPressed: () => setState(() {
            _action.lookForWords();
          }),
        ),
        ToolMenuIcon(
          icon: _action.favorite ? Icons.bookmark : _bookMark,
          color: _action.favorite ? Colors.yellow : null,
          onPressed: () => setState(() {
            _action.showFavorites();
          }),
        ),
      ],
    );
  }

  AppBar _buildSelectedAppBar() {
    return AppBar(
      leading: ToolMenuIcon(
        icon: Icons.close,
        onPressed: () => setState(() {
          _action.disableSelect();
          Provider.of<ChatProvider>(context, listen: false).update();
        }),
      ),
      actions: <Widget>[
        Expanded(
          child: Align(
            alignment: const Alignment(0, 0.15),
            child: Text(
              '${_action.selectedItemIndexes.length}',
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        _createEditIcon(),
        ToolMenuIcon(
          icon: Icons.copy,
          onPressed: () => setState(() {
            _action.copyText();
          }),
        ),
        ToolMenuIcon(
          icon: _bookMark,
          onPressed: () => setState(() {
            _action.changeFavoriteStatus();
          }),
        ),
        ToolMenuIcon(
          icon: Icons.delete,
          onPressed: () => setState(() {
            _action.deleteMessage();
          }),
        ),
      ],
    );
  }

  Widget _createEditIcon() {
    final icon = Icons.edit;
    if (_action.selectedItemIndexes.length == 1 && !_action.editMode) {
      return ToolMenuIcon(
        icon: icon,
        onPressed: () => setState(() {
          _action.turnOnEditMode();
        }),
      );
    } else {
      return ToolMenuIcon(icon: icon, color: Colors.transparent);
    }
  }

  Widget _buildMessageList(Size size) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: _action.events.length,
        itemBuilder: (_, i) {
          final index = _action.events.length - 1 - i;
          return InkWell(
            child: EventBox(
              event: _action.events[index],
              size: size,
              isSelected: _action.events[index].isSelected,
            ),
            onTap: () {
              _selectElement(index, _action.selectedMode);
            },
            onLongPress: () {
              _selectElement(index);
            },
          );
        },
      ),
    );
  }

  void _selectElement(int index, [bool extraCondition = true]) {
    setState(() {
      if (!_action.editMode && extraCondition) _action.handleSelecting(index);
    });
  }

  Widget _getInputBox(Size size) {
    return Container(
      width: size.width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeyBoardIcon(
            icon: Icons.attach_file,
            onPressed: _openDialog,
          ),
          Expanded(
            child: TextField(
              controller: _fieldText,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _local?.enterFieldHint ?? '',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: secondaryMessageTextColor,
                ),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          KeyBoardIcon(
            icon: !_action.editMode ? Icons.send : Icons.edit,
            onPressed: !_action.editMode ? _sendEvent : _turnOffEditMode,
          ),
        ],
      ),
    );
  }

  void _openDialog() {
    AttachDialog(context, _local, _sendEvent).open();
  }

  void _sendEvent([String? path]) {
    if (_fieldText.text.isEmpty && path == null) return;

    setState(() {
      widget.chat.events.add(
        Event(
          message: _fieldText.text,
          dateTime: DateTime.now(),
          photoPath: path,
        ),
      );
      _fieldText.clear();

      Provider.of<ChatProvider>(context, listen: false).update();
    });
  }

  void _turnOffEditMode() {
    setState(() {
      _action.turnOffEditMode();
    });
  }

  Future<bool> _handleBackButton() async {
    if (!_action.selectedMode) {
      return true;
    } else {
      setState(() {
        _action.disableSelect();
      });
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
