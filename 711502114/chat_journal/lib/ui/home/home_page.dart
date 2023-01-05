import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../theme/colors.dart';
import '../../theme/theme_model.dart';
import 'chat.dart';
import 'chat_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final desc = local?.chatDescription ?? '';

    final _chats = <Chat>[
      Chat(title: 'Travel', description: desc, assetsLink: 'assets/plane.svg'),
      Chat(title: 'Family', description: desc, assetsLink: 'assets/sofa.svg'),
      Chat(title: 'Sports', description: desc, assetsLink: 'assets/gym.svg'),
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
                _createMessagesList(_chats),
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

  Expanded _createMessagesList(List<Chat> chats) {
    return Expanded(
      child: ListView.separated(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return InkWell(
            hoverColor: hoverElementColor,
            onTap: () => print('TAP'),
            child: ChatCard(chat: chats[index]),
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
