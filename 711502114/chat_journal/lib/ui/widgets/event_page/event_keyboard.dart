import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubit/event/event_cubit.dart';
import '../../../theme/colors.dart';
import '../../../utils/utils.dart';
import 'attach_dialog.dart';
import 'keyboard_icon.dart';

class EventKeyboard extends StatelessWidget {
  final double width;
  final TextEditingController fieldText;
  final EventCubit cubit;
  final Function() update;

  EventKeyboard({
    Key? key,
    required this.width,
    required this.fieldText,
    required this.cubit,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Container(
      width: width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeyBoardIcon(
            icon: cubit.category?.icon ?? Icons.category,
            onPressed: _openCloseCategoryList,
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
          if (checkOrientation(context))
            KeyBoardIcon(
              icon: Icons.image,
              onPressed: () {
                AttachDialog(context, local, _sendEvent).open();
              },
            ),
          KeyBoardIcon(
            icon: !cubit.editMode ? Icons.send : Icons.edit,
            onPressed: !cubit.editMode ? _sendEvent : _turnOffEditMode,
          ),
        ],
      ),
    );
  }

  void _openCloseCategoryList() {
    if (!cubit.categoryMode) {
      cubit.openCategory();
    } else {
      cubit.closeCategory();
    }
  }

  void _sendEvent([String? path]) {
    if (fieldText.text.isEmpty && path == null) return;

    cubit.addEvent(fieldText.text, path);
    update();
    fieldText.clear();
  }

  void _turnOffEditMode() {
    cubit.finishEditMode(
      fieldText: fieldText,
      editSuccess: true,
    );

    update();
  }
}
