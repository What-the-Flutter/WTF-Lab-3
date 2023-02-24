import 'package:chat_journal/utils/icons.dart';
import 'package:flutter/material.dart';

import '../models/events_tab.dart';
import '../providers/events_tabs_provider.dart';
import '../theme/custom_theme_inherited.dart';

class TabPage extends StatefulWidget {
  final String title;
  final EventsTab? editedTab;

  const TabPage({Key? key, required this.title, this.editedTab})
      : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final TextEditingController _controller = TextEditingController();
  final EventsTabsProvider _provider = EventsTabsProvider();
  EventsTab? editedTab;
  Icon? _selectedIcon;
  String _name = '';

  @override
  void initState() {
    super.initState();
    editedTab = widget.editedTab;
    if (editedTab != null) {
      _controller.text = editedTab!.name;
      _selectedIcon = editedTab!.icon;
      _name = editedTab!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CustomThemeInherited.of(context).mode.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            CustomThemeInherited.of(context).mode.appBarTheme.backgroundColor,
        title: Text(
          widget.title,
          style: CustomThemeInherited.of(context).mode.textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
        child: Column(
          children: [
            _inputRow(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) =>
                    _iconVariant(IconMap.iconVariants[index]),
                itemCount: IconMap.iconVariants.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedIcon != null && _name.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                if (editedTab != null) {
                  editedTab!.name = _name;
                  editedTab!.icon = _selectedIcon!;
                } else {
                  _provider.tabs
                      .add(EventsTab(name: _name, icon: _selectedIcon!));
                }
                Navigator.pop(context);
              },
              tooltip: 'Add',
              child: editedTab == null
                  ? Icon(
                      Icons.add,
                      color: CustomThemeInherited.of(context)
                          .mode
                          .primaryIconTheme
                          .color,
                    )
                  : Icon(
                      Icons.check,
                      color: CustomThemeInherited.of(context)
                          .mode
                          .primaryIconTheme
                          .color,
                    ),
              backgroundColor: Colors.amber,
            )
          : FloatingActionButton(
              onPressed: () {
                print(_controller.text.isNotEmpty);
                print(_selectedIcon != null);
                Navigator.pop(context);
              },
              tooltip: 'Cancel',
              child: Icon(
                Icons.close,
                color: CustomThemeInherited.of(context)
                    .mode
                    .primaryIconTheme
                    .color,
              ),
              backgroundColor: Colors.amber,
            ),
    );
  }

  Widget _iconVariant(Icon icon) {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedIcon = icon;
      }),
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: icon == _selectedIcon ? Colors.amber : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: CustomThemeInherited.of(context).mode.cardColor,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
      ),
    );
  }

  Widget _inputRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: CustomThemeInherited.of(context).mode.cardColor,
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: CustomThemeInherited.of(context).mode.textTheme.labelLarge,
              controller: _controller,
              decoration: const InputDecoration(
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              onChanged: (s) => setState(() {
                _name = s;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
