import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/app_theme/app_theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool light0 = false;

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
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  value: light0,
                  onChanged: (value) {
                    setState(() {
                      light0 = !light0;
                      ReadContext(context).read<AppThemeCubit>().changeTheme();
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
