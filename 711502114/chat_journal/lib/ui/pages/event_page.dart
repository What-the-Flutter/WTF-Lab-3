import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../provider/chat_provider.dart';
import '../tools/event_action.dart';
import '../widgets/event_page/attach_dialog.dart';
import '../widgets/event_page/event_box.dart';
import '../widgets/event_page/event_keyboard.dart';
import '../widgets/event_page/info_box.dart';
import '../widgets/event_page/tool_menu_icon.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final _bookMark = Icons.bookmark_border_outlined;
  late final TextEditingController _fieldText;
  late AppLocalizations? _local;
  late EventAction _action;

  @override
  void initState() {
    super.initState();
    _fieldText = TextEditingController();
    _action = EventAction(widget.chat, _fieldText);
  }

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.chat.events.isNotEmpty
                  ? _buildMessageList(size)
                  : InfoBox(size: size, mainTitle: widget.chat.title),
              EventKeyboard(
                width: size.width,
                fieldText: _fieldText,
                fieldHint: _local?.enterFieldHint ?? '',
                isEditMode: _action.editMode,
                openDialog: _openDialog,
                sendEvent: _sendEvent,
                turnOffEditMode: _turnOffEditMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    final selected = _action.selectedMode;
    return AppBar(
      title: selected ? null : Text(widget.chat.title),
      centerTitle: !selected,
      leading: selected
          ? ToolMenuIcon(
              icon: Icons.close,
              onPressed: () => setState(() {
                _action.disableSelect();
                Provider.of<ChatProvider>(context, listen: false).update();
              }),
            )
          : null,
      actions: <Widget>[
        if (selected) ...[
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
        ] else ...[
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
        ]
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

      Provider.of<ChatProvider>(context, listen: false).update();
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
