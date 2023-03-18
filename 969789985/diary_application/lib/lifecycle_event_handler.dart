import 'package:flutter/material.dart';

import 'src/core/util/logger.dart';
import 'src/core/util/typedefs.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final FutureVoidCallback pausedCallback;
  final FutureVoidCallback resumedCallback;

  LifecycleEventHandler({
    required this.pausedCallback,
    required this.resumedCallback,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    logger('Lifecycle is: $state', 'App_Lifecycle');

    if(state == AppLifecycleState.resumed) await resumedCallback();

    if(state == AppLifecycleState.paused) await pausedCallback();
  }
}
