import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat.dart';
import '../widgets/app_theme/app_theme_cubit.dart';

class AddChatScreen extends StatefulWidget {
  @override
  State<AddChatScreen> createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  int _pickedIcon = 0;
  String? _pageName;
  bool _isPicked = false;
  Icon _actionIcon = const Icon(Icons.clear);
  final _textController = TextEditingController();
  final List<IconData> _icons = [
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

  void _setActionButtonIcon() {
    _actionIcon = _isPicked
        ? Icon(
            Icons.done,
            color: ReadContext(context).read<AppThemeCubit>().state.customTheme.iconColor,
          )
        : Icon(
            Icons.clear,
            color: ReadContext(context).read<AppThemeCubit>().state.customTheme.iconColor,
          );
  }

  Widget _selectableIcon(int index) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Icon(
              _icons[index],
              color:ReadContext(context).read<AppThemeCubit>().state.customTheme.iconColor,
              size: 36,
            ),
          ),
          if (index == _pickedIcon)
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
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
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setActionButtonIcon();
    return Scaffold(
      backgroundColor: ReadContext(context).read<AppThemeCubit>().state.customTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 14),
              alignment: Alignment.center,
              child: Text(
                'Create a new page',
                style: TextStyle(
                  color: ReadContext(context).read<AppThemeCubit>().state.customTheme.textColor,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(
                  color: ReadContext(context).read<AppThemeCubit>().state.customTheme.textColor,
                ),
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor:
                  ReadContext(context).read<AppThemeCubit>().state.customTheme.auxiliaryColor,
                ),
                onChanged: (text) {
                  setState(() {
                    _isPicked = _textController.text.isNotEmpty ? true : false;
                    _setActionButtonIcon();
                  });
                },
              ),
            ),
            Container(
              // height: 500,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  return _selectableIcon(index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isPicked) {
            Navigator.pop(
              context,
              Chat(
                name: _textController.text,
                pageIcon: _icons[_pickedIcon],
              ),
            );
          } else {
            Navigator.pop(context);
          }
        },
        backgroundColor: ReadContext(context).read<AppThemeCubit>().state.customTheme.actionColor,
        child: _actionIcon,
      ),
    );
  }
}
