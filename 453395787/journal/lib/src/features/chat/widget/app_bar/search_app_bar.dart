part of '../../view/message_search_page.dart';

class _SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const _SearchAppBar({
    super.key,
  });

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<_SearchAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: context.pop,
        icon: const Icon(
          Icons.arrow_back_outlined,
        ),
      ),
      title: TextFormField(
        controller: _controller,
        autofocus: true,
        onChanged: MessageSearchScope.of(context).onSearchQueryChanged,
      ),
    );
  }
}
