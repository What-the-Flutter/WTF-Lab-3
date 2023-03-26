import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choosing_background_image.dart';
import 'settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  ListTile _createThemeTile(BuildContext context) {
    return ListTile(
      iconColor: Theme.of(context).disabledColor,
      leading: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.invert_colors,
        ),
      ),
      title: Text(
        'Theme',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        'Light / Dark',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
      ),
      onTap: () {
        context.read<SettingsCubit>().toggleTheme();
      },
    );
  }

  ListTile _createFontSizeTile(BuildContext context) {
    return ListTile(
      iconColor: Theme.of(context).disabledColor,
      leading: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.text_fields,
        ),
      ),
      title: Text(
        'Font Size',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        'Small / Default / Large',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
      ),
      onTap: () {
        context.read<SettingsCubit>().toggleFontSize();
      },
    );
  }

  ListTile _createResetTile(BuildContext context) {
    return ListTile(
      iconColor: Theme.of(context).disabledColor,
      leading: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.settings_backup_restore,
        ),
      ),
      title: Text(
        'Reset All Preferences',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        'Reset all Visual Customizations',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
      ),
      onTap: () {
        context.read<SettingsCubit>().resetAllPreferences();
      },
    );
  }

  ListTile _createBubbleAlignmentTile(
      BuildContext context, SettingsState state) {
    return ListTile(
        iconColor: Theme.of(context).disabledColor,
        leading: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            state.isRightToLeft
                ? Icons.format_align_right
                : Icons.format_align_left,
          ),
        ),
        title: Text(
          'Bubble Alignment',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        subtitle: Text(
          'Force right-to-left bubble alignment',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
              ),
        ),
        trailing: Switch(
          value: state.isRightToLeft,
          onChanged: context.read<SettingsCubit>().toggleBubbleAlignment,
          activeColor: Theme.of(context).primaryColorLight,
        ));
  }

  ListTile _createCenterDateTile(BuildContext context, SettingsState state) {
    return ListTile(
        iconColor: Theme.of(context).disabledColor,
        leading: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.flourescent,
          ),
        ),
        title: Text(
          'Center Date Bubble',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
        trailing: Switch(
          value: state.isCenterDate,
          onChanged: context.read<SettingsCubit>().toggleCenterDate,
          activeColor: Theme.of(context).primaryColorLight,
        ));
  }

  ListTile _createBackgroundImageTile(BuildContext context) {
    return ListTile(
      iconColor: Theme.of(context).disabledColor,
      leading: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(
          Icons.wallpaper,
        ),
      ),
      title: Text(
        'Background Image',
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        'Chat background image',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChoosingBackgroundImage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: ListView(
              children: [
                Text(
                  'Visuals',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                ),
                _createThemeTile(context),
                const Divider(),
                _createFontSizeTile(context),
                const Divider(),
                _createResetTile(context),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'Chat Interface',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                  ),
                ),
                _createBubbleAlignmentTile(context, state),
                const Divider(),
                _createCenterDateTile(context, state),
                const Divider(),
                _createBackgroundImageTile(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
