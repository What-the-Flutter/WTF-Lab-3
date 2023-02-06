import 'package:flutter/material.dart';

class EventsCard extends StatelessWidget {
  const EventsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Icon icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap:() {
          print('Click to EventsCard');
        },
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.background,
            ),
            child: icon,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

}