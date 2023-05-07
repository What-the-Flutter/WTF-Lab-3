import 'package:flutter/material.dart';
import '../models/chat.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key, required this.chat});

  //final String title;
  Chat chat;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    final bgColor = theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.search), color: bgColor),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
              color: bgColor)
        ],
      ),
      body: Column(
        children: [
          //add events here
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bubble_chart),
                      color: bgColor,
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintStyle: style,
                        hintText: 'Enter event',
                      ),
                      style: style,
                      onSubmitted: (input) {},
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_enhance_outlined),
                      color: bgColor,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
