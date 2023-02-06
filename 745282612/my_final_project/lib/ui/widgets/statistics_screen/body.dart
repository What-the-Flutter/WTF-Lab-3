import 'package:flutter/material.dart';

import 'package:my_final_project/ui/widgets/statistics_screen/popularity_statistics.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/summary_statistics.dart';

class BodyStatistics extends StatelessWidget {
  final int index;
  final List _widgetOptions = const <Widget>[
    SummaryStatistics(),
    PopularStatistics(),
  ];

  const BodyStatistics({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetOptions[index];
  }
}
