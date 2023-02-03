import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubit/event/event_cubit.dart';
import '../../../cubit/home/home_cubit.dart';
import '../../../theme/colors.dart';
import 'attach_dialog.dart';
import 'keyboard_icon.dart';

class EventKeyboard extends StatelessWidget {
  final double width;
  final TextEditingController fieldText;
  final bool editMode;

  late final BuildContext widgetContext;

  EventKeyboard({
    Key? key,
    required this.width,
    required this.fieldText,
    required this.editMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    widgetContext = context;
    final local = AppLocalizations.of(context);
    return Container(
      width: width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeyBoardIcon(
            icon: Icons.attach_file,
            onPressed: () => _openDialog(local),
          ),
          Expanded(
            child: TextField(
              controller: fieldText,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: local?.enterFieldHint ?? '',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: secondaryMessageTextColor,
                ),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          KeyBoardIcon(
            icon: !editMode ? Icons.send : Icons.edit,
            onPressed: !editMode ? _sendEvent : _turnOffEditMode,
          ),
        ],
      ),
    );
  }

  void _openDialog(AppLocalizations? local) {
    AttachDialog(widgetContext, local, _sendEvent).open();
  }

  void _sendEvent([String? path]) {
    if (fieldText.text.isEmpty && path == null) return;

    BlocProvider.of<EventCubit>(widgetContext).addEvent(fieldText.text, path);
    updateChatLastEvent();
    fieldText.clear();
  }

  void _turnOffEditMode() {
    BlocProvider.of<EventCubit>(widgetContext).finishEditMode(
      fieldText: fieldText,
      editSuccess: true,
    );

    updateChatLastEvent();
  }

  void updateChatLastEvent() {
    BlocProvider.of<HomeCubit>(widgetContext, listen: false).update();
  }
}
