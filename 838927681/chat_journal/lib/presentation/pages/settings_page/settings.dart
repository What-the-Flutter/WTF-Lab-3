import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pick_background_image.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: _settingsBody(context, state),
        );
      },
    );
  }

  Widget _settingsBody(BuildContext context, SettingsState state) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: [
          Text(
            'Visuals',
            style: context.watch<SettingsCubit>().state.fontSize.bodyText2!,
          ),
          _visualsBody(context, state),
          Text(
            'Security',
            style: context.watch<SettingsCubit>().state.fontSize.bodyText2!,
          ),
          _securityBody(context, state),
        ],
      ),
    );
  }

  Widget _visualsBody(BuildContext context, SettingsState state) {
    return Column(
      children: [
        _divider(),
        ListTile(
          title: Text(
            'Theme',
            style: state.fontSize.bodyText2!,
          ),
          leading: const Icon(
            Icons.invert_colors,
            size: 30,
          ),
          subtitle: Text(
            'Light / Dark',
            style: state.fontSize.bodyText1!,
          ),
          onTap: () {
            context.read<SettingsCubit>().changeTheme();
          },
        ),
        _divider(),
        Row(
          children: [
            Flexible(
              child: ListTile(
                title: Text(
                  'FontSize',
                  style: state.fontSize.bodyText2!,
                ),
                leading: const Icon(Icons.format_size),
                subtitle: Text(
                  'Small / Default / Large',
                  style: state.fontSize.bodyText1!,
                ),
                onTap: () => _changeFontSizeDialog(state, context),
              ),
            ),
          ],
        ),
        _divider(),
        ListTile(
          title: Text(
            'Bubble Alignment',
            style: state.fontSize.bodyText2!,
          ),
          leading: Icon(
            state.bubbleAlignment
                ? Icons.format_align_right
                : Icons.format_align_left,
          ),
          subtitle: Text(
            'Force right-to-left bubble alignment',
            style: state.fontSize.bodyText1!,
          ),
          trailing: Switch(
            value: state.bubbleAlignment,
            onChanged: context.read<SettingsCubit>().setBubbleAlignment,
          ),
        ),
        _divider(),
        ListTile(
          title: Text(
            'Center Date Bubble',
            style: state.fontSize.bodyText2!,
          ),
          leading: const Icon(Icons.date_range),
          trailing: Switch(
            value: state.centerDate,
            onChanged: context.read<SettingsCubit>().setCenterDate,
          ),
        ),
        _divider(),
        ListTile(
          title: Text(
            'Background Image',
            style: state.fontSize.bodyText2!,
          ),
          subtitle: Text(
            'Chat background image',
            style: state.fontSize.bodyText1!,
          ),
          leading: const Icon(Icons.image),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PickBackgroundImage(state: state),
            ),
          ),
        ),
        _divider(),
        ListTile(
          title: Text(
            'Reset All Preferences',
            style: state.fontSize.bodyText2!,
          ),
          subtitle: Text(
            'Reset all Visual Customizations',
            style: state.fontSize.bodyText1!,
          ),
          leading: const Icon(Icons.refresh),
          onTap: context.read<SettingsCubit>().setDefault,
        ),
      ],
    );
  }

  Widget _securityBody(BuildContext context, SettingsState state) {
    return Column(
      children: [
        _divider(),
        ListTile(
          title: Text(
            'Fingerprint',
            style: state.fontSize.bodyText2!,
          ),
          leading: const Icon(Icons.fingerprint),
          subtitle: Text(
            'Enable Fingerprint unlock',
            style: state.fontSize.bodyText1!,
          ),
          trailing: Switch(
            value: state.isLocked,
            onChanged: (value) {
              context.read<SettingsCubit>().setIsLocked(value);
            },
          ),
        ),
      ],
    );
  }

  void _changeFontSizeDialog(SettingsState state, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Font Size', style: state.fontSize.headline3!),
                ListTile(
                    title: Text(
                      'Small',
                      style: state.fontSize.bodyText1!,
                    ),
                    onTap: () {
                      context.read<SettingsCubit>().setFontSize(-1);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                    title: Text(
                      'Default',
                      style: state.fontSize.bodyText1!,
                    ),
                    onTap: () {
                      context.read<SettingsCubit>().setFontSize(0);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  title: Text(
                    'Large',
                    style: state.fontSize.bodyText1!,
                  ),
                  onTap: () {
                    context.read<SettingsCubit>().setFontSize(1);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: state.fontSize.headline4,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 2,
    );
  }
}
