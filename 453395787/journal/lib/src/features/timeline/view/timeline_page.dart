import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../message_filter/message_filter.dart';
import '../../message_filter/widget/message_filter_scope.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageFilterScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            locale.Pages.timeline.i18n(),
          ),
        ),
        floatingActionButton: const FilterFloatingActionButton(),
      ),
    );
  }
}
