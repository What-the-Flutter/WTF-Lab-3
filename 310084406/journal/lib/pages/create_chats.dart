import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateChat extends StatefulWidget {
  final String name;
  const CreateChat({super.key, required this.name});

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  List<String> messages = [];
  String text = '';
  DateTime now = DateTime.now();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.name}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: messages.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              subtitle:
                                  Text('${now.day}-${now.month}-${now.year}'),
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
                                                    messages.removeAt(
                                                        messages.length -
                                                            1 -
                                                            index);
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
                                                  final data = ClipboardData(
                                                      text: messages[
                                                          messages.length -
                                                              1 -
                                                              index]);
                                                  Clipboard.setData(data);
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.copy),
                                            label:
                                                const Text('Copy to Clipboard'),
                                          ),
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
                                                                '${messages[messages.length - 1 - index]}',
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
                                                                  left: 10.0,
                                                                  right: 10),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                setState(
                                                                  () {
                                                                    if (text
                                                                        .isNotEmpty) {
                                                                      messages[messages
                                                                              .length -
                                                                          1 -
                                                                          index] = text;
                                                                      Navigator.pop(
                                                                          context);
                                                                    } else {
                                                                      messages.removeAt(messages
                                                                              .length -
                                                                          1 -
                                                                          index);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                              child: const Text(
                                                                  'update')),
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
                                  side: const BorderSide(width: 2)),
                              title: Text(
                                  '${messages[messages.length - 1 - index]}'),
                            ),
                          )
                        ],
                      );
                    },
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 370, top: 100, left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Try adding events',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Add your first event to "Travel" page by entering some text in the text box below and hitting the send button. Long tap the send button to align the event in the opposite direction. Tap on the bookmark icon on the top right corner to show the bookmarked events only.',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 3, right: 3, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions,
                            size: 26,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: myController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: 'Enter event',
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(
                      () {
                        if (myController.text.isNotEmpty) {
                          messages.add(myController.text);

                          myController.clear();
                        }
                      },
                    );
                  },
                  minWidth: 0,
                  child: const Icon(
                    Icons.send,
                    size: 27,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
