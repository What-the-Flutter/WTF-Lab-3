// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/home/home_cubit.dart';
import '../../cubit/home/home_state.dart';
import '../../models/chat.dart';
import '../../utils/icons.dart';
import '../../utils/utils.dart';
import '../widgets/add_chat_page/add_chat_keyboard.dart';
import '../widgets/add_chat_page/chat_icon.dart';

class AddChatPage extends StatefulWidget {
  final Chat? chat;

  const AddChatPage({Key? key, this.chat}) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  IconData _fabIcon = Icons.close;
  int _iconIndex = 0;
  final _icons = IconList.data;
  late final TextEditingController _fieldText;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _fieldText = TextEditingController();
    _fieldText.addListener(_changeFABIcon);

    if (widget.chat != null) {
      for (int i = 0; i < _icons.length; i++) {
        if (widget.chat?.iconData == _icons[i]) {
          _iconIndex = i;
          break;
        }
      }

      _fieldText.text = widget.chat?.title ?? '';
      _isEditMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final orientation = MediaQuery.of(context).orientation;
    final itemRowCount = orientation == Orientation.portrait ? 4 : 8;

    return Scaffold(
      resizeToAvoidBottomInset: checkOrientation(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: orientation == Orientation.portrait ? 70 : 30),
            Text(
              !_isEditMode ? local?.addNewChat ?? '' : local?.editChat ?? '',
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 10),
            AddChatKeyboard(
              fieldText: _fieldText,
              pageLabel: local?.addPageLabel ?? '',
            ),
            _buildIconsTable(itemRowCount),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, _) {
          return Align(
            alignment: const Alignment(1, 0.87),
            child: FloatingActionButton(
              onPressed: () => _addOrEditChat(context),
              child: Icon(_fabIcon),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconsTable(int itemRowCount) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemRowCount,
          mainAxisSpacing: 40,
          crossAxisSpacing: 40,
        ),
        itemCount: _icons.length,
        itemBuilder: (_, index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: ChatIcon(
              child: Icon(_icons[index]),
              index: index,
              pageIndex: _iconIndex,
            ),
            onTap: () => setState(() => _iconIndex = index),
          );
        },
      ),
    );
  }

  void _changeFABIcon() {
    if (_fabIcon == Icons.close && _fieldText.text.isNotEmpty ||
        _fabIcon == Icons.check && _fieldText.text.isEmpty) {
      setState(() {
        _fabIcon = _fabIcon == Icons.close ? Icons.check : Icons.close;
      });
    }
  }

  void _addOrEditChat(BuildContext context) {
    if (_fieldText.text.isNotEmpty) {
      final cubit = context.read<HomeCubit>();
      if (widget.chat == null) {
        cubit.add(
          title: _fieldText.text,
          iconData: _icons[_iconIndex],
        );
      } else {
        cubit.edit(
          widget.chat?.id ?? 0,
          title: _fieldText.text,
          iconData: _icons[_iconIndex],
        );
      }
    }

    closePage(context);
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
