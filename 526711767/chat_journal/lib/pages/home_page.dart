import 'package:flutter/material.dart';

import './chat_page.dart';
import './tab_page.dart';
import '../models/events_tab.dart';
import '../providers/events_tabs_provider.dart';
import '../theme/custom_theme_inherited.dart';
import '../theme/themes.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventsTabsProvider _provider = EventsTabsProvider();
  bool _isDark = false;
  EventsTab? selectedTab;

  @override
  void initState() {
    super.initState();
    _provider.tabs.add(
      EventsTab(
        name: 'New',
        icon: const Icon(
          Icons.factory,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeInherited(
      mode: _isDark ? ThemeVariants.darkMode : ThemeVariants.lightMode,
      child: MaterialApp(
        title: 'Chat Diary',
        theme: ThemeVariants.darkMode,
        home: Builder(
          builder: (innerContext) {
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: CustomThemeInherited.of(innerContext)
                      .mode
                      .appBarTheme
                      .backgroundColor,
                  title: Text(
                    widget.title,
                    style: CustomThemeInherited.of(innerContext)
                        .mode
                        .textTheme
                        .headlineLarge,
                  ),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      icon: _isDark
                          ? const Icon(Icons.light_mode)
                          : const Icon(Icons.dark_mode),
                      tooltip: 'Mode',
                      onPressed: () {
                        setState(() {
                          _isDark = !_isDark;
                        });
                      },
                    ),
                  ]),
              drawer: const JournalDrawer(),
              backgroundColor: CustomThemeInherited.of(innerContext)
                  .mode
                  .scaffoldBackgroundColor,
              body: ListView(
                children: [
                  const QuestionnaireBotButton(),
                  const Divider(color: Colors.grey),
                  ListView.builder(
                    itemCount: _provider.tabs.length,
                    itemBuilder: (context, index) =>
                        _eventsTab(_provider.tabs[index], context),
                    shrinkWrap: true,
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.of(innerContext).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const TabPage(title: 'Add new page'),
                    ),
                  );
                  if (!mounted) return;
                  setState(() {});
                },
                tooltip: 'Increment',
                child: Icon(
                  Icons.add,
                  color: CustomThemeInherited.of(innerContext)
                      .mode
                      .primaryIconTheme
                      .color,
                ),
                backgroundColor: Colors.amber,
              ),
              bottomNavigationBar: const JournalNavigationBar(),
            );
          },
        ),
      ),
    );
  }

  Widget _eventsTab(EventsTab tab, BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog<String>(
          context: context,
          builder: _pageMenu,
        );
        selectedTab = tab;
      },
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(5),
          child: tab.icon,
        ),
        title: Text(
          tab.name,
          style: CustomThemeInherited.of(context).mode.textTheme.headlineMedium,
        ),
        subtitle: Text(
          tab.recentRecord(),
          style: CustomThemeInherited.of(context).mode.textTheme.labelSmall,
        ),
        iconColor: CustomThemeInherited.of(context).mode.iconTheme.color,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(tab: tab),
            ),
          );
          if (!mounted) return;
          setState(() {});
        },
      ),
    );
  }

  Widget _pageMenu(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        _pageMenuOption(
            icon: const Icon(Icons.info),
            name: 'Info',
            iconColor: Colors.teal.shade300,
            callback: () => Navigator.pop(context, 'Info')),
        _pageMenuOption(
            icon: const Icon(Icons.push_pin),
            name: 'Pin/Unpin Page',
            iconColor: Colors.green,
            callback: () => Navigator.pop(context, 'Pin/Unpin Page')),
        _pageMenuOption(
            icon: const Icon(Icons.edit),
            name: 'Edit',
            iconColor: Colors.blueAccent,
            callback: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabPage(
                    title: 'Edit tab',
                    editedTab: selectedTab,
                  ),
                ),
              );
              if (!mounted) return;
              setState(() {
                selectedTab = null;
              });
              Navigator.pop(context, 'Edit');
            }),
        _pageMenuOption(
            icon: const Icon(Icons.delete),
            name: 'Delete',
            iconColor: Colors.red,
            callback: () {
              setState(() {
                _provider.tabs.remove(selectedTab);
                selectedTab = null;
              });
              Navigator.pop(context, 'Delete');
            }),
      ],
    );
  }

  ListTile _pageMenuOption(
      {required Icon icon,
      required String name,
      required Color iconColor,
      required GestureTapCallback callback}) {
    return ListTile(
      leading: icon,
      title: Text(
        name,
      ),
      iconColor: iconColor,
      onTap: callback,
    );
  }
}

class JournalNavigationBar extends StatefulWidget {
  const JournalNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JournalNavigationBarState();
}

class _JournalNavigationBarState extends State<JournalNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: CustomThemeInherited.of(context)
          .mode
          .bottomNavigationBarTheme
          .selectedItemColor,
      unselectedItemColor: CustomThemeInherited.of(context)
          .mode
          .bottomNavigationBarTheme
          .unselectedItemColor,
      selectedIconTheme: CustomThemeInherited.of(context)
          .mode
          .bottomNavigationBarTheme
          .selectedIconTheme,
      unselectedIconTheme: CustomThemeInherited.of(context)
          .mode
          .bottomNavigationBarTheme
          .unselectedIconTheme,
      backgroundColor: CustomThemeInherited.of(context)
          .mode
          .bottomNavigationBarTheme
          .backgroundColor,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.document_scanner),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
          ),
          label: 'Timeline',
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }
}

class QuestionnaireBotButton extends StatelessWidget {
  const QuestionnaireBotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_neutral,
                color: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineMedium!
                    .color,
              ),
              Text(' Questionnaire Bot',
                  style: CustomThemeInherited.of(context)
                      .mode
                      .textTheme
                      .headlineMedium),
            ],
          ),
        ),
        onPressed: () {},
        style: CustomThemeInherited.of(context).mode.elevatedButtonTheme.style,
      ),
    );
  }
}

class JournalDrawer extends StatelessWidget {
  const JournalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:
          CustomThemeInherited.of(context).mode.drawerTheme.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100.0,
            child: DrawerHeader(
              child: Text(
                'Chat Journal',
                style: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineLarge,
              ),
              decoration: BoxDecoration(
                  color: CustomThemeInherited.of(context).mode.primaryColor),
            ),
          ),
          ListTile(
            title: Text('All Pages',
                style: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineMedium),
            leading: Icon(
              Icons.home,
              color: CustomThemeInherited.of(context).mode.iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Statistics',
                style: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineMedium),
            leading: Icon(
              Icons.auto_graph,
              color: CustomThemeInherited.of(context).mode.iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Search',
                style: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineMedium),
            leading: Icon(
              Icons.search,
              color: CustomThemeInherited.of(context).mode.iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Settings',
                style: CustomThemeInherited.of(context)
                    .mode
                    .textTheme
                    .headlineMedium),
            leading: Icon(
              Icons.settings,
              color: CustomThemeInherited.of(context).mode.iconTheme.color,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
