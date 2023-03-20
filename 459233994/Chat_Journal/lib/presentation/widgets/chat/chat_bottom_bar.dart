import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/event.dart';
import '../../screens/chat/chat_cubit.dart';
import '../../screens/chat/chat_state.dart';
import '../app_theme/app_theme_cubit.dart';

class ChatBottomBar extends StatefulWidget {
  final String chatId;

  ChatBottomBar({
    required this.chatId,
  });

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final _textController = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();
  final List<IconData> _icons = [
    Icons.remove_circle,
    Icons.title,
    Icons.account_balance,
    Icons.search,
    Icons.star,
    Icons.sports_basketball,
    Icons.airplanemode_active,
    Icons.style,
    Icons.accessibility,
    Icons.wine_bar_sharp,
    Icons.weekend_rounded,
    Icons.airport_shuttle_sharp,
    Icons.apartment_outlined,
    Icons.apple,
    Icons.beach_access,
    Icons.book,
    Icons.catching_pokemon,
    Icons.castle,
  ];
  int _pickedIcon = 0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectableCategory(),
        Row(
          key: _globalKey,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.label,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .iconColor,
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: ReadContext(context)
                          .read<AppThemeCubit>()
                          .state
                          .customTheme
                          .textColor,
                    ),
                  ),
                  hintText: 'Enter event',
                ),
                onChanged: (value) {
                  ReadContext(_globalKey.currentContext!)
                      .read<ChatCubit>()
                      .changeBottomBarState(value);
                },
              ),
            ),
            _sendIcon(),
          ],
        ),
      ],
    );
  }

  void _getFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      ReadContext(context).read<ChatCubit>().addEventToChat(
            Event(
              chatId: widget.chatId,
              imageData: pickedFile.path,
            ),
          );
    }
  }

  Widget _sendIcon() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.isInputFilled == true) {
          return InkWell(
            child: Icon(
              Icons.send,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .iconColor,
            ),
            onTap: () {
              _pickedIcon == 0
                  ? ReadContext(context).read<ChatCubit>().addEventToChat(
                        Event(
                          textData: _textController.text,
                          chatId: widget.chatId,
                        ),
                      )
                  : ReadContext(context).read<ChatCubit>().addEventToChat(
                        Event(
                          chatId: widget.chatId,
                          textData: _textController.text,
                          category: _icons[_pickedIcon],
                        ),
                      );
              ReadContext(_globalKey.currentContext!)
                  .read<ChatCubit>()
                  .changeBottomBarState('');
              _textController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
            },
          );
        } else {
          return InkWell(
            child: Icon(
              Icons.add_a_photo,
              color: ReadContext(context)
                  .read<AppThemeCubit>()
                  .state
                  .customTheme
                  .iconColor,
            ),
            onTap: () => _getFromGallery(context),
          );
        }
      },
    );
  }

  Widget _selectableCategory() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.isInputFilled == true) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _icons.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _selectableIcon(index);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _selectableIcon(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
      ),
      child: InkWell(
        child: Stack(
          children: <Widget>[
            if (index == 0)
              Align(
                alignment: Alignment.center,
                child: Icon(
                  _icons[index],
                  color: Colors.red,
                  size: 36,
                ),
              ),
            if (index != 0)
              Align(
                alignment: Alignment.center,
                child: Icon(
                  _icons[index],
                  color: ReadContext(context)
                      .read<AppThemeCubit>()
                      .state
                      .customTheme
                      .iconColor,
                  size: 36,
                ),
              ),
            if (index == _pickedIcon)
              Container(
                // padding: const EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 14,
                ),
              )
          ],
        ),
        onTap: () {
          setState(
            () {
              _pickedIcon = index;
            },
          );
        },
      ),
    );
  }
}
