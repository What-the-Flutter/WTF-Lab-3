import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widget/settings/main_section/settings_body.dart';
import '../../widget/theme/theme_scope.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                systemNavigationBarColor: Color(
                  ThemeScope.of(context).state.primaryColor,
                ),
              ),
            );
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const SettingsBody(),
    );
  }
}
