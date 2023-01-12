import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../../theme/theme_model.dart';
import 'chat.dart';
import 'chat_card.dart';
import 'event/message_data.dart';
import 'event/messenger_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO: fix bug with list updating!!!
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    final _chatCards = <ChatCard>[
      ChatCard(
        chat: Chat(
          title: 'Travel',
          messages: [],
        ),
        assetsLink: 'assets/plane.svg',
      ),
      ChatCard(
        chat: Chat(
          title: 'Family',
          messages: [
            MessageData(
              'Family is very important!',
              DateTime.now(),
            ),
          ],
        ),
        assetsLink: 'assets/sofa.svg',
      ),
      ChatCard(
        chat: Chat(title: 'Sports', messages: [
          MessageData(
            'I like going',
            DateTime(2021, 10, 15, 9, 30, 2),
            isFavorite: true,
          ),
          MessageData(
            'to the gym!',
            DateTime(2022, 10, 15, 10, 45, 12),
            isFavorite: true,
          ),
          MessageData(
            "I'll go to the gym 3 times a week" * 200,
            DateTime(2023, 10, 15, 23, 59, 46),
          ),
        ]),
        assetsLink: 'assets/gym.svg',
      ),
    ];

    return Consumer<ThemeModel>(
      builder: (context, themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(local?.homePage ?? ''),
            centerTitle: true,
            leading: const Icon(Icons.menu_sharp),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.invert_colors),
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                _createBotBox(context),
                const SizedBox(height: 5),
                _createMessagesList(_chatCards),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            tooltip: local?.increaseButtonHint,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Container _createBotBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: botBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/bot.svg',
            height: 25,
            width: 25,
            color: iconColor,
          ),
          const SizedBox(width: 28),
          Text(
            AppLocalizations.of(context)?.bot ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Bold',
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Expanded _createMessagesList(List<ChatCard> cards) {
    return Expanded(
      child: ListView.separated(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return InkWell(
            hoverColor: hoverElementColor,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MessengerPage(chat: cards[index].chat),
                ),
              );
            },
            child: cards[index],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: hoverElementColor,
          );
        },
      ),
    );
  }
}
