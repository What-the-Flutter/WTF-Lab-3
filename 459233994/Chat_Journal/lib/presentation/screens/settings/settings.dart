import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/app_theme/app_theme_cubit.dart';
import 'settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchTheme = false;
  bool switchDateBubble = false;
  bool switchBubbleAlignment = false;
  late int groupValue;
  List<int> value = [12, 16, 20];

  _SettingsScreenState() {
    groupValue = value[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .themeColor,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .keyColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Center(
            child: Text(
              'Settings',
              style: TextStyle(
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .keyColor),
            ),
          ),
        ),
      ),
      backgroundColor: ReadContext(context)
          .read<AppThemeCubit>()
          .state
          .customTheme
          .backgroundColor,
      body: Column(
        children: <Widget>[
          _themeChoice(),
          _sideBubbleChoice(),
          _fontChoice(),
          _dateBubbleChoice(),
          _chatBackgroundImageChoice(),
          _setToDefaultButton(),
        ],
      ),
    );
  }

  Widget _themeChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 64, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Black Theme',
            style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor),
          ),
          Switch(
            value: switchTheme,
            onChanged: (value) {
              setState(() {
                switchTheme = !switchTheme;
                ReadContext(context).read<AppThemeCubit>().changeTheme();
              });
            },
          )
        ],
      ),
    );
  }

  Widget _sideBubbleChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 64, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Left/Right bubble',
            style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor),
          ),
          Switch(
            value: switchBubbleAlignment,
            onChanged: (value) {
              setState(
                () {
                  switchBubbleAlignment = !switchBubbleAlignment;
                  ReadContext(context)
                      .read<SettingsCubit>()
                      .changeBubbleAlignment(switchBubbleAlignment);
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _dateBubbleChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 64, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Center date bubble',
            style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor),
          ),
          Switch(
            value: switchDateBubble,
            onChanged: (value) {
              setState(() {
                switchDateBubble = !switchDateBubble;
                ReadContext(context)
                    .read<SettingsCubit>()
                    .changeDateBubble(switchDateBubble);
              });
            },
          )
        ],
      ),
    );
  }

  Widget _fontChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Font Size',
            style: TextStyle(
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .textColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 128.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RadioListTile(
                    title: Text(
                      'Small',
                      style: TextStyle(
                          color: ReadContext(context)
                              .read<AppThemeCubit>()
                              .state
                              .customTheme
                              .textColor),
                    ),
                    value: value[0],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                        ReadContext(context)
                            .read<SettingsCubit>()
                            .changeFont(value);
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Medium',
                      style: TextStyle(
                          color: ReadContext(context)
                              .read<AppThemeCubit>()
                              .state
                              .customTheme
                              .textColor),
                    ),
                    value: value[1],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                        ReadContext(context)
                            .read<SettingsCubit>()
                            .changeFont(value);
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Large',
                      style: TextStyle(
                          color: ReadContext(context)
                              .read<AppThemeCubit>()
                              .state
                              .customTheme
                              .textColor),
                    ),
                    value: value[2],
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                        ReadContext(context)
                            .read<SettingsCubit>()
                            .changeFont(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _chatBackgroundImageChoice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 64, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Chat background image',
            style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {_getFromGallery(context);});
            },
            child: const Text('Pick image'),
          ),
        ],
      ),
    );
  }

  Widget _setToDefaultButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 64, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Reset to default',
            style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                switchTheme = false;
                switchDateBubble = false;
                groupValue = value[1];
                ReadContext(context)
                    .read<SettingsCubit>()
                    .changeFont(groupValue);
                ReadContext(context)
                    .read<SettingsCubit>()
                    .changeBubbleAlignment(switchTheme);
                ReadContext(context)
                    .read<SettingsCubit>()
                    .changeDateBubble(switchDateBubble);
                ReadContext(context)
                    .read<SettingsCubit>()
                    .setBackGroundImage(null);
              });
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _getFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      ReadContext(context).read<SettingsCubit>().setBackGroundImage(
            pickedFile.path,
          );
    }
    print(ReadContext(context).read<SettingsCubit>().state.backgroundImage);
  }
}
