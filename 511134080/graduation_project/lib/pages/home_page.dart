import 'package:flutter/material.dart';
import 'package:graduation_project/providers/events_provider.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../widgets/event_list_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<ChatModel> chats;

  @override
  void initState() {
    super.initState();
    chats = Provider.of<EventsProvider>(context, listen: false).chats;
  }

  Widget _createListTile(int index) {
    return EventListTile(
      chat: chats[index],
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.invert_colors),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _createBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            onTap: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: Theme.of(context).highlightColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.smart_toy_outlined,
                  size: 32,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Questionnaire Bot',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            visualDensity: const VisualDensity(vertical: 3),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: chats.length,
            itemBuilder: (_, index) {
              return Consumer<EventsProvider>(
                builder: (_, __, ___) => Material(
                  child: _createListTile(index),
                ),
              );
            },
            separatorBuilder: (_, __) {
              return const Divider(
                thickness: 2,
              );
            },
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _createBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.assignment,
          ),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
          ),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 16,
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }
}