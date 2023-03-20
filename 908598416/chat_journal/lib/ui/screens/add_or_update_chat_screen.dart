import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/constants/color_constants.dart';
import '/data/constants/icons.dart';
import '../../bloc/cubit/chats/chats_cubit.dart';
import '../../bloc/cubit/sign_in/sign_in_cubit.dart';

class AddOrUpdateChat extends StatefulWidget {
  final bool isEdited;
  final String currentChatId;
  final String chatName;
  final int icon;

  AddOrUpdateChat(
      {required this.isEdited,
      required this.currentChatId,
      required this.chatName,
      required this.icon});

  @override
  State<AddOrUpdateChat> createState() => _AddOrUpdateChat();
}

class _AddOrUpdateChat extends State<AddOrUpdateChat> {
  late final SignInCubit _authCubit;
  late final ChatsCubit _chatCubit;
  late final TextEditingController _chatNameController;
  late final String _currentUserId;
  late int _selectedIcon = 0;

  @override
  void initState() {
    super.initState();
    if(widget.isEdited){
      _selectedIcon = widget.icon;
    }

    _authCubit = BlocProvider.of<SignInCubit>(context);
    _chatCubit = BlocProvider.of<ChatsCubit>(context);
    _currentUserId = _authCubit.getUserFirebaseId()!;
    _chatNameController = TextEditingController();
    _chatNameController.text = widget.chatName;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                        size: 30, color: ColorConstants.greyColor),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    'Create New Chat',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextFormField(
                controller: _chatNameController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                icons[_selectedIcon],
                size: 40,
              ),
            ),
            widget.isEdited
                ? ElevatedButton.icon(
                    onPressed: () => _chatCubit.updateChat(
                        context,
                        _currentUserId,
                        widget.currentChatId,
                        _chatNameController.text.toString(),
                        _selectedIcon),
                    icon: const Icon(Icons.done),
                    label: const Text('update chat'))
                : ElevatedButton.icon(
                    onPressed: () => _chatCubit.addChat(
                        context,
                        _chatNameController.text.toString(),
                        _currentUserId,
                        _selectedIcon),
                    icon: const Icon(Icons.add),
                    label: const Text('add chat')),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  var item = icons.elementAt(index);
                  return IconButton(
                    icon: Icon(item, size: 50),
                    onPressed: () {
                      setState(() {
                        _selectedIcon = index;
                      });
                    },
                  );
                },
                physics: const ScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
