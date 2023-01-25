import 'package:flutter/material.dart';

import '../../ui/utils/dimensions.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Radii.applicationConstantSmall),
              topRight: Radius.circular(Radii.applicationConstantSmall),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    ),
  );
}