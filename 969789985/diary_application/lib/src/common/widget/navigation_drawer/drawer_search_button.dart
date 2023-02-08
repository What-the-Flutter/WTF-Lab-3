import 'package:flutter/material.dart';

import '../../values/dimensions.dart';

class DrawerSearchButton extends StatelessWidget {
  const DrawerSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.circle),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.only(
            top: Insets.large,
            bottom: Insets.large,
          ),
          child: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(width: Insets.extraLarge),
              Text('Search'),
            ],
          ),
        ),
      ),
    );
  }
}
