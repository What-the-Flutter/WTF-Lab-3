import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/theme_enums.dart';
import '../../utils/custom_theme.dart';
import 'settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _cubit = GetIt.I<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.palette_outlined),
                    title: Text('Theme'),
                    subtitle: Text('Light / Dark'),
                  ),
                  onTap: _cubit.switchThemeType,
                ),
                const Divider(),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text('Font Size'),
                    subtitle: Text('Small / Default / Large'),
                  ),
                  onTap: () async {
                    final fontSizeType = await showDialog<FontSizeType>(
                      context: context,
                      builder: (_) => const _FontPicker(),
                    );

                    if (fontSizeType != null) {
                      await _cubit.switchFontSizeType(fontSizeType);
                    }
                  },
                ),
                const Divider(),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.table_rows_rounded),
                    title: Text('Bubble Alignment'),
                    subtitle: Text('Force right-to-left bubble alignment'),
                  ),
                  onTap: _cubit.switchBubbleAlignmentType,
                ),
                const Divider(),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.image_outlined),
                    title: Text('Background Image'),
                    subtitle: Text('Chat background image'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const _BackgroundImagePicker(),
                      ),
                    );
                  },
                ),
                const Divider(),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.restart_alt),
                    title: Text('Reset All Preferences'),
                    subtitle: Text('Reset all Visual Customizations'),
                  ),
                  onTap: _cubit.restoreSettings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BackgroundImagePicker extends StatefulWidget {
  const _BackgroundImagePicker({super.key});

  @override
  State<_BackgroundImagePicker> createState() => _BackgroundImagePickerState();
}

class _BackgroundImagePickerState extends State<_BackgroundImagePicker> {
  final _cubit = GetIt.I<SettingsCubit>();

  void _onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      _cubit.saveBackgroundImage(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Background Image'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (_, state) {
          if (state.backgroundImage == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 10.0,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Click the button below to set the Background Image',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Pick an Image'),
                    onPressed: _onPickImage,
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 60.0,
                  ),
                  child: Image.memory(state.backgroundImage!),
                ),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Unset image'),
                  ),
                  onTap: _cubit.resetBackgroundImage,
                ),
                InkWell(
                  child: const ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Pick a new Image'),
                  ),
                  onTap: _onPickImage,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _FontPicker extends StatelessWidget {
  const _FontPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        color: CustomTheme.of(context).themeData.backgroundColor,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Font Size'),
              TextButton(
                child: const Text('Small'),
                onPressed: () => Navigator.pop(context, FontSizeType.small),
              ),
              TextButton(
                child: const Text('Medium'),
                onPressed: () => Navigator.pop(context, FontSizeType.medium),
              ),
              TextButton(
                child: const Text('Large'),
                onPressed: () => Navigator.pop(context, FontSizeType.large),
              ),
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
