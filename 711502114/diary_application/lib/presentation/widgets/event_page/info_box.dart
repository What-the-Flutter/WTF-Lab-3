import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoBox extends StatelessWidget {
  final String mainTitle;
  final bool isTimeline;

  const InfoBox({
    Key? key,
    this.mainTitle = '',
    this.isTimeline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    String title, desc;
    if (local != null) {
      if (!isTimeline) {
        title = local.messageNotificationTitle;
        title = title.replaceAll('{}', mainTitle);
        desc = local.messageNotificationDesc;
        desc = desc.replaceAll('{}', mainTitle);
      } else {
        title = local.emptyTimelineTitle;
        desc = local.emptyTimelineDesc;
      }
    } else {
      title = '';
      desc = '';
    }

    if (MediaQuery.of(context).orientation == Orientation.landscape &&
        WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Align(
        alignment: const Alignment(0, -1),
        child: Container(
          decoration: BoxDecoration(
            color: BlocProvider.of<SettingsCubit>(context).isDark
                ? const Color.fromRGBO(37, 47, 57, 1)
                : const Color.fromRGBO(77, 157, 206, 0.7),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  desc,
                  style: TextStyle(
                    color: BlocProvider.of<SettingsCubit>(context).isDark
                        ? Colors.grey
                        : Colors.white,
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
