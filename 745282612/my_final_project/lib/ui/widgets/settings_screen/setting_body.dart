import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:share_plus/share_plus.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> with SingleTickerProviderStateMixin {
  late AnimationController _resetAnimationController;

  @override
  void initState() {
    _resetAnimationController = AnimationController(
      vsync: this,
    );
    _resetAnimationController.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          Navigator.pop(context);
          _resetAnimationController.reset();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _resetAnimationController.dispose();
    super.dispose();
  }

  Future<void> showResetDialog(BuildContext context) => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Lottie.asset(
                  'assets/update.json',
                  controller: _resetAnimationController,
                  onLoaded: (composition) {
                    _resetAnimationController.duration = composition.duration;
                    _resetAnimationController.forward();
                  },
                ),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        children: [
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(
              S.of(context).add_section,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            onTap: () {
              context.read<SettingCubit>().changeAddStatus();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNewScreen(
                    textController: '',
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.invert_colors),
            title: Text(
              S.of(context).change_theme,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
            subtitle: Text(
              'Light/Dark',
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () async {
              await showResetDialog(context);
              context.read<SettingCubit>().changeTheme();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: Text(
              S.of(context).cnange_font_size,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            subtitle: Text(
              'Small/Medium/Large',
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () async {
              await showResetDialog(context);
              context.read<SettingCubit>().changeFontSize();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(
              S.of(context).choose_image,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: context.read<SettingCubit>().changeBackgroundImage,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bubble_chart),
            title: Text(
              S.of(context).change_bubble_alignment,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            subtitle: Text(
              'Left/Right',
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () async {
              await showResetDialog(context);
              context.read<SettingCubit>().changeBubbleAligment();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.align_horizontal_left),
            title: Text(
              S.of(context).change_date_bubble,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            subtitle: Text(
              'Left/Center',
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () async {
              await showResetDialog(context);
              context.read<SettingCubit>().changeDateBubble();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(
              S.of(context).share_app,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () {
              Share.share('It\'s my app');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.restore_rounded),
            title: Text(
              S.of(context).reset_setting,
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText2!.fontSize,
              ),
            ),
            onTap: () async {
              await showResetDialog(context);
              context.read<SettingCubit>().resetSetting();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
