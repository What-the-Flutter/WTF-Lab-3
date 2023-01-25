import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';

import '../../basic/providers/chat_provider.dart';
import '../../ui/utils/icons.dart';

class SearchBar extends StatefulWidget {
  final ChatProvider provider;
  final TextEditingController searchTextFieldController;

  SearchBar({
    super.key,
    required this.provider,
    required this.searchTextFieldController,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  double _width = 60.0;

  bool _isSearchMode = false;

  @override
  Widget build(BuildContext context) => _searchContainer(context);

  Widget _searchContainer(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _width,
        curve: _isSearchMode ? Curves.fastOutSlowIn : Curves.decelerate,
        child: Row(
          children: [
            _animatedSearchButton(context),
            _searchTextField(),
          ],
        ),
      );

  Widget _animatedSearchButton(BuildContext context) => AnimatedIconButton(
        duration: const Duration(milliseconds: 500),
        onPressed: () {
          setState(() {
            _isSearchMode = !_isSearchMode;
            _isSearchMode
                ? _width = MediaQuery.of(context).size.width * 0.7
                : _width = 60.0;
          });
          if (!_isSearchMode) widget.searchTextFieldController.clear();
        },
        icons: [
          const AnimatedIconItem(
            icon: Icon(
              Icons.search,
              size: IconsSize.standard,
            ),
          ),
          const AnimatedIconItem(
            icon: Icon(
              Icons.close,
              size: IconsSize.standard,
            ),
          ),
        ],
      );

  Widget _searchTextField() {
    return Visibility(
      visible: _isSearchMode,
      child: Expanded(
        child: TextField(
          controller: widget.searchTextFieldController,
          autofocus: true,
          onChanged: (value) => widget.provider.updateListeners(),
          decoration: const InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
              hintText: 'Search here...'),
        ),
      ),
    );
  }
}
