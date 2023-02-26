import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../general/custom_dialog.dart';
import '../../../../../../core/util/resources/strings.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';
import 'information_dialog.dart';

class ChatterInformationButton extends StatelessWidget {
  final ChatModel chat;

  const ChatterInformationButton({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.appConstantSmall),
      child: MaterialButton(
        onPressed: () => _informationDialog(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.appConstant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Insets.medium),
          child: Row(
            children: const [
              Icon(Icons.info_outline),
              SizedBox(width: Insets.appConstantSmall),
              Text('Information'),
            ],
          ),
        ),
      ),
    );
  }

  void _informationDialog(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        dialogTitle: Strings.chatInformationTitle,
        dialogDescription: ChatterInformationDialog(chat: chat),
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
}
