import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/chat_provider.dart';
import '../theme/colors.dart';
import '../theme/theme_inherited.dart';
import '../widgets/chat_card.dart';
import 'messenger_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

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
                ThemeInherited.of(context).switchTheme();
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
            _createMessagesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: local?.increaseButtonHint,
        child: const Icon(Icons.add),
      ),
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
            ),
          )
        ],
      ),
    );
  }

  Expanded _createMessagesList() {
    final chats = Provider.of<ChatProvider>(context).chats;
    return Expanded(
      child: ListView.separated(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MessengerPage(chat: chats[index]),
                ),
              );
            },
            child: ChatCard(chat: chats[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
      ),
    );
  }
}
