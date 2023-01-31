import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '../../../common/utils/locale.dart' as locale;

class TimelineAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TimelineAppBar({
    super.key,
    required this.onTextChanged,
    required this.onIsFavoriteChanged,
  });

  final void Function(String text) onTextChanged;
  final void Function(bool isFavorite) onIsFavoriteChanged;

  @override
  _TimelineAppBarState createState() => _TimelineAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TimelineAppBarState extends State<TimelineAppBar> {
  final TextEditingController _controller = TextEditingController();
  bool isSearchFieldShown = false;
  bool isBookmarkButtonActive = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isSearchFieldShown
          ? IconButton(
              icon: const Icon(
                Icons.close_outlined,
              ),
              onPressed: () {
                setState(() {
                  isSearchFieldShown = false;
                });
                _controller.text = '';
                widget.onTextChanged('');
              },
            )
          : null,
      title: isSearchFieldShown
          ? TextFormField(
              keyboardType: TextInputType.text,
              controller: _controller,
              autofocus: true,
              onChanged: widget.onTextChanged,
              decoration: const InputDecoration.collapsed(
                hintText: 'search',
              ),
            )
          : Text(locale.Pages.timeline.i18n()),
      actions: [
        if (!isSearchFieldShown)
          IconButton(
            onPressed: () {
              setState(() {
                isSearchFieldShown = true;
              });
            },
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
        IconButton(
          onPressed: () {
            setState(() {
              isBookmarkButtonActive = !isBookmarkButtonActive;
            });
            widget.onIsFavoriteChanged(
              isBookmarkButtonActive,
            );
          },
          icon: Icon(
            isBookmarkButtonActive
                ? Icons.bookmark
                : Icons.bookmark_outline_outlined,
          ),
        ),
      ],
    );
  }
}
