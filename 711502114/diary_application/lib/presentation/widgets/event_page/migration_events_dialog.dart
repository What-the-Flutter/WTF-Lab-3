import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/icons.dart';
import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MigrationEventsDialog extends StatelessWidget {
  final Function(Chat chat) handleClicking;

  const MigrationEventsDialog({
    Key? key,
    required this.handleClicking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    final chats = cubit.state.chats;
    return AlertDialog(
      backgroundColor: dialogBackgroundColor,
      title: Text(local?.eventMigration ?? ''),
      content: Container(
        width: 0,
        height: 250,
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (_, i) {
            return Column(
              children: [
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    handleClicking(chats[i]);
                    cubit.update();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    color: botBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(IconMap.data[chats[i].iconNumber]),
                        const SizedBox(width: 20),
                        Text('${chats[i].title}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5)
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 100,
            child: OutlinedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(local?.cancel ?? ''),
              onPressed: Navigator.of(context).pop,
            ),
          ),
        ),
      ],
    );
  }
}
