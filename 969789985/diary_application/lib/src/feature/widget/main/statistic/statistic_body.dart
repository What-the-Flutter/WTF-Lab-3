import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../theme/theme_scope.dart';
import 'activity/activity_body.dart';
import 'summary/summary_body.dart';

class StatisticBody extends StatelessWidget {
  const StatisticBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.large),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Theme(
              data: ThemeData().copyWith(
                splashColor: Color(
                  ThemeScope.of(context).state.primaryItemColor,
                ),
              ),
              child: TabBar(
                labelColor: Theme.of(context).indicatorColor,
                unselectedLabelColor: Theme.of(context).hintColor,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: _CircleTabIndicator(
                  color: Theme.of(context).indicatorColor,
                  radius: Radii.small,
                ),
                splashBorderRadius: BorderRadius.circular(Radii.circle),
                tabs: [
                  const Tab(
                    text: 'Summary',
                  ),
                  const Tab(
                    text: 'Activity',
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  SummaryBody(),
                  ActivityBody(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const _CircleTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(
      color: color,
      radius: radius,
    );
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  const _CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(
      Canvas canvas,
      Offset offset,
      ImageConfiguration configuration,
      ) {
    final paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;

    final circleOffset = Offset(
      (configuration.size!.width / 2 - radius / 2) + 3,
      configuration.size!.height - radius * 2,
    );

    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
