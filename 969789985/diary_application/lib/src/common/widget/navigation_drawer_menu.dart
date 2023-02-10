import 'package:flutter/material.dart';

import '../values/dimensions.dart';

class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) => NavigationDrawer(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Radii.appConstantSmall),
                topRight: Radius.circular(Radii.appConstantSmall),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      );
}
