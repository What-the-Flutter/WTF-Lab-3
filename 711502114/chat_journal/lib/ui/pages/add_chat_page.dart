// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';
import '../../theme/colors.dart';
import '../../utils/icons.dart';
import '../widgets/page_icon.dart';

class AddChatPage extends StatefulWidget {
  const AddChatPage({Key? key}) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final _fieldText = TextEditingController();
  IconData _fabIcon = Icons.close;
  int _pageIndex = 0;
  final _icons = IconList.data;

  @override
  void initState() {
    super.initState();
    _fieldText.addListener(_changeFABIcon);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 70),
            Text(
              local?.addNewChat ?? '',
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 10),
            _buildTextField(local),
            _buildIconsTable(),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: const Alignment(1, 0.87),
        child: FloatingActionButton(
          onPressed: _addNewChat,
          child: Icon(_fabIcon),
        ),
      ),
    );
  }

  Widget _buildTextField(AppLocalizations? local) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _fieldText,
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        textInputAction: TextInputAction.newline,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          labelText: local?.addPageLabel ?? '',
          hintStyle: TextStyle(
            fontSize: 20,
            color: secondaryMessageTextColor,
          ),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildIconsTable() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 40,
          crossAxisSpacing: 40,
        ),
        itemCount: _icons.length,
        itemBuilder: (_, index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: PageIcon(
              child: Icon(_icons[index]),
              index: index,
              pageIndex: _pageIndex,
            ),
            onTap: () {
              setState(() => _pageIndex = index);
            },
          );
        },
      ),
    );
  }

  // Widget _firstIcon() {
  //   return Center(
  //     child: Text(
  //       _fieldText.text.isNotEmpty ? _fieldText.text.characters.first : 'N',
  //       style: const TextStyle(fontSize: 24),
  //     ),
  //   );
  // }

  void _changeFABIcon() {
    if (_fabIcon == Icons.close && _fieldText.text.isNotEmpty ||
        _fabIcon == Icons.check && _fieldText.text.isEmpty) {
      setState(() {
        _fabIcon = _fabIcon == Icons.close ? Icons.check : Icons.close;
      });
    }
  }

  void _addNewChat() {
    if (_fieldText.text.isNotEmpty) {
      Provider.of<ChatProvider>(context, listen: false).add(
        title: _fieldText.text,
        iconData: _icons[_pageIndex],
      );
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
