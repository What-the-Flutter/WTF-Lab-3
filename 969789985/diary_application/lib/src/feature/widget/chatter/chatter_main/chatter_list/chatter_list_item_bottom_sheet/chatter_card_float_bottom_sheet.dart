import 'package:flutter/material.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';
import 'chatter_delete_button.dart';
import 'chatter_edit_button.dart';
import 'chatter_information_button.dart';
import 'chatter_pin_button.dart';

class ChatterCardFloatBottomSheet extends StatelessWidget {
  final ChatModel chat;

  const ChatterCardFloatBottomSheet({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.appConstantMedium),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.appConstant),
          color: Theme.of(context).primaryColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChatterInformationButton(chat: chat),
              ChatterPinButton(chat: chat),
              ChatterEditButton(chat: chat),
              ChatterDeleteButton(chat: chat),
            ],
          ),
        ),
      ),
    );
  }
}
