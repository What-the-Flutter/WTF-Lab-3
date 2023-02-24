import 'package:flutter/material.dart';
import '../../pages/create_chats.dart';
import '../home_page_widgets/constanst.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: chats.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: chats.length,
                    padding: const EdgeInsets.all(20.0),
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              tileColor: Theme.of(context).primaryColor,
                              subtitle: const Text('Tap to enter the chat'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreateChat(
                                      name: 'chat',
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                setState(
                                  () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(width: 1)),
                                        contentPadding:
                                            const EdgeInsets.all(11),
                                        children: [
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          SimpleDialog(
                                                        children: [
                                                          Text(
                                                              'it was created: ${createdDate[index]}'),
                                                        ],
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            side:
                                                                const BorderSide(
                                                                    width: 1)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(11),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.info_outline),
                                              label: const Text('Info')),
                                          ElevatedButton.icon(
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    chats.removeAt(index);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.delete),
                                              label:
                                                  const Text('Delete event')),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        SimpleDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side:
                                                              const BorderSide(
                                                                  width: 1)),
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: TextFormField(
                                                            initialValue:
                                                                '${chats[index]}',
                                                            onChanged: (value) {
                                                              setState(
                                                                () {
                                                                  text = value;
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                setState(
                                                                  () {
                                                                    if (text
                                                                        .isNotEmpty) {
                                                                      chats[index] =
                                                                          text;
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      chats.removeAt(
                                                                          index);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                  'rename Chat')),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                            label: const Text('Edit'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(width: 1)),
                              contentPadding: const EdgeInsets.all(11),
                              //shape: const Border(bottom: BorderSide()),
                              title: Text(
                                '${chats[index]}',
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 420, top: 100, left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Chat list is empty :(',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Add your first chat!',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          FloatingActionButton(
            onPressed: (() {
              setState(
                () {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1)),
                      contentPadding: const EdgeInsets.all(11),
                      children: [
                        TextField(
                          controller: myController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Enter chat name',
                              border: InputBorder.none),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              setState(
                                () {
                                  if (myController.text.isNotEmpty) {
                                    chats.add(myController.text);
                                    var now = DateTime.now();
                                    var date = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        now.hour,
                                        now.minute,
                                        now.second);
                                    myController.clear();
                                    createdDate.add('$date');
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            },
                            icon: const Icon(Icons.create_new_folder),
                            label: const Text('create'))
                      ],
                    ),
                  );
                },
              );
            }),
            tooltip: 'add chats',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
