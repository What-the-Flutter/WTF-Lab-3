import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat_cubit.dart';
import '../cubits/chats_state.dart';
import '../journal.dart';
import '../models/chat.dart';
import 'add_chat_page.dart';
import 'events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateAndDisplay(BuildContext context, {Chat? chat}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChatPage(chat: chat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Journal.of(context).changeTheme();
            },
            icon: const Icon(Icons.invert_colors),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: theme.colorScheme.background,
            margin: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 30,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  style: style,
                  'Questionnaire Bot',
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatsCubit, ChatsState>(builder: (_, state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Material(
                    child: buildListTile(state.chats[index], context),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 5);
                },
                itemCount: state.chats.length,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplay(context);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'daily'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'explore'),
        ],
      ),
    );
  }

  ListTile buildListTile(Chat chat, BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          shape: BoxShape.circle,
        ),
        child: chat.icon,
      ),
      title: Text(chat.name),
      subtitle: const Text('No events. Click to create one'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsPage(
              chat: chat,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _longPressMenu(context, chat);
          },
        );
      },
    );
  }

  Column _longPressMenu(BuildContext context, Chat chat) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.teal,
          ),
          title: Text('Info'),
        ),
        const ListTile(
          leading: Icon(
            Icons.attach_file,
            color: Colors.green,
          ),
          title: Text('Pin/Unpin Page'),
        ),
        const ListTile(
          leading: Icon(
            Icons.archive,
            color: Colors.yellow,
          ),
          title: Text('Archive Page'),
        ),
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.blue,
          ),
          title: const Text('Edit Page'),
          onTap: () {
            Navigator.pop(context);
            _navigateAndDisplay(context, chat: chat);
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          title: const Text('Delete Page'),
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return _deletionMenu(context, chat);
              },
            );
          },
        ),
      ],
    );
  }

  Padding _deletionMenu(BuildContext context, Chat chat) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delete Page?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Are you sure you want to delete this '
            'page? Entries of this page will still be '
            'accessible in the timeline',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text('Delete'),
            onTap: () {
              context.read<ChatsCubit>().delete(chat);
              Navigator.pop(context);
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.cancel,
              color: Colors.blue,
            ),
            title: const Text('Cancel'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
