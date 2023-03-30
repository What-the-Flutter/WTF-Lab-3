import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/chat/event_cubit.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hashtager/widgets/hashtag_text_field.dart';

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
      color: BlocProvider.of<SettingsCubit>(context).isDark
          ? const Color.fromRGBO(37, 47, 57, 1)
          : const Color.fromRGBO(77, 157, 206, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeyBoardIcon(
            icon: cubit.category?.icon ?? Icons.category,
            onPressed: _openCloseCategoryList,
          ),
          Expanded(
            child: HashTagTextField(
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
                  color: BlocProvider.of<SettingsCubit>(context).isDark
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
              onDetectionTyped: (_) => cubit.changeTagStatus(true),
              onDetectionFinished: () => cubit.changeTagStatus(false),
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
