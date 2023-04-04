import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/creation/add_chat_page.dart';
import 'package:diary_application/presentation/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class MenuDrawer extends StatelessWidget {
  final AppLocalizations? local;

  const MenuDrawer({Key? key, this.local}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                  '${DateFormat('EEEE, dd MMM yyyy').format(DateTime.now())}',
                  style: textTheme(context).headline1!),
            ),
          ),
          ListTile(
            title: Text(
              local?.helpSpread ?? '',
              style: textTheme(context).bodyText1!,
            ),
            leading: const Icon(Icons.card_giftcard),
            onTap: () async {
              final text =
                  '''${local?.appShare}\n${local?.applicationProjectLink}''';
              await Share.share(text);
            },
          ),
          ListTile(
            title: Text(
              local?.search ?? '',
              style: textTheme(context).bodyText1!,
            ),
            leading: const Icon(Icons.search),
          ),
          ListTile(
            title: Text(
              local?.notification ?? '',
              style: textTheme(context).bodyText1!,
            ),
            leading: const Icon(Icons.notifications),
          ),
          ListTile(
            title: Text(
              local?.statistics ?? '',
              style: textTheme(context).bodyText1!,
            ),
            leading: const Icon(Icons.analytics),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              local?.settings ?? '',
              style: textTheme(context).bodyText1!,
            ),
            onTap: () {
              openNewPageWithAnim(const Settings(), AnimationType.fadeIn);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              local?.addCategoryMenu ?? '',
              style: textTheme(context).bodyText1!,
            ),
            onTap: () {
              closePage(context);
              openNewPageWithAnim(
                const AddChatPage(isCategoryMode: true),
                AnimationType.zoom,
              );
            },
          ),
          ListTile(
            title: Text(
              local?.feedback ?? '',
              style: textTheme(context).bodyText1!,
            ),
            leading: const Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}
