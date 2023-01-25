import 'package:flutter/material.dart';

import '../../ui/utils/dimensions.dart';
import '../../ui/utils/icons.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: Insets.applicationConstantLarge),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(Insets.applicationConstantSmall),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.info_outline, size: IconsSize.extraLarge),
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Radii.applicationConstant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Insets.applicationConstantMedium),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
