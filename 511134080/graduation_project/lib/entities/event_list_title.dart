import 'package:flutter/material.dart';
import 'package:graduation_project/pages/event_page.dart';

class EventListTile extends StatelessWidget {
  final Icon icon;

  final String title;

  final String subtitle;

  const EventListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: icon,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                      title: title,
                    )));
      },
    );
  }
}
