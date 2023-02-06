import 'package:flutter/material.dart';

import '../../domain/entities/event_page.dart';
import '../widgets/app_theme/app_theme.dart';
import '../widgets/app_theme/theme.dart';

class AddEventPage extends StatefulWidget {
  late final CustomTheme _theme;

  AddEventPage({
    required theme,
  }) : _theme = theme;


  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int _pickedIcon = 0;
  String? _pageName;
  bool _isPicked = false;
  Icon _actionIcon = const Icon(Icons.clear);
  late final List<IconData> _icons = [
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
  late FloatingActionButton _floatingActionButton;
  final _textController = TextEditingController();

  void _setActionButton() {
    setState(() {
      _setActionButtonIcon();
      _floatingActionButton = FloatingActionButton(
        onPressed: () {
          if (_isPicked) {
            Navigator.pop(
              context,
              EventPage(
                name: _textController.text,
                pageIcon: Icon(
                  _icons[_pickedIcon],
                  color: widget._theme.iconColor,
                ),
              ),
            );
          } else {
            Navigator.pop(context);
          }
        },
        backgroundColor: widget._theme.actionColor,
        child: _actionIcon,
      );
    });
  }

  void _setActionButtonIcon() {
    if (_isPicked) {
      _actionIcon = Icon(
        Icons.done,
        color: widget._theme.iconColor,
      );
    } else {
      _actionIcon = Icon(
        Icons.clear,
        color: widget._theme.iconColor,
      );
    }
  }

  Widget _selectableIcon(int index) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Icon(
              _icons[index],
              color: widget._theme.iconColor,
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
    _setActionButton();
    return AppTheme(
      theme: widget._theme,
      child: Scaffold(
        backgroundColor: widget._theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 14),
                alignment: Alignment.center,
                child: Text(
                  'Create a new page',
                  style: TextStyle(
                    color: widget._theme.textColor,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: TextStyle(
                    color: widget._theme.textColor,
                  ),
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    fillColor: widget._theme.auxiliaryColor,
                  ),
                  onChanged: (text) {
                    setState(() {
                      if (_textController.text.isNotEmpty) {
                        _isPicked = true;
                      } else {
                        _isPicked = false;
                      }
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
        floatingActionButton: _floatingActionButton,
      ),
    );
  }
}
