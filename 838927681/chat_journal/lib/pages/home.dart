import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../models/event.dart';
import '../theme/colors.dart';
import '../widgets/questionnaire_bot.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const QuestionnaireBotButton(),
            Expanded(child: _myJournalList()),
            //MyJournalList()
          ],
        ),
        _floatingActionButton(),
      ],
    );
  }

  Widget _myJournalList() {
    final journalList = <Chat>[
      Chat(name: 'Travel', icon: Icons.travel_explore, events: []),
      Chat(
        name: 'Family',
        icon: Icons.family_restroom,
        events: [
          Event(
              text: 'My Family',
              dateTime: DateTime.now().subtract(const Duration(hours: 24))),
          Event(text: 'My big big family', dateTime: DateTime.now()),
        ],
      ),
      Chat(name: 'Sport', icon: Icons.sports, events: []),
    ];

    return Column(
      children: [
        _divider(),
        Flexible(
          child: ListView.builder(
            itemCount: journalList.length,
            padding: const EdgeInsets.all(0.0),
            itemBuilder: (context, i) {
              final journalItem = journalList[i];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      journalItem.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      journalItem.events.isNotEmpty
                          ? journalItem
                              .events[journalItem.events.length - 1].text
                          : 'No events, Click to create one',
                    ),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.blueGrey,
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          journalItem.icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(chat: journalItem),
                        ),
                      );
                    },
                  ),
                  _divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _floatingActionButton() {
    return AnimatedPositioned(
      child: FloatingActionButton(
        backgroundColor: ChatJournalColors.fabColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {},
      ),
      duration: const Duration(milliseconds: 300),
      right: 20,
      bottom: 20,
      //curve: Curves.easeInOut,
    );
  }
}
