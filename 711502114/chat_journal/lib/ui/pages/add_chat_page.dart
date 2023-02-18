import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/creation/creation_cubit.dart';
import '../../cubit/creation/creation_state.dart';
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
  String _title = '';
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();

    if (widget.chat != null) {
      _title = widget.chat?.title ?? '';
      _isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final orientation = MediaQuery.of(context).orientation;
    final itemRowCount = orientation == Orientation.portrait ? 4 : 8;

    return BlocBuilder<CreationCubit, CreationState>(
      builder: (context, state) {
        final cubit = context.read<CreationCubit>();
        return WillPopScope(
          onWillPop: () async {
            cubit.reset();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: checkOrientation(context),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: orientation == Orientation.portrait ? 70 : 30),
                  Text(
                    !_isEdit ? local?.addNewChat ?? '' : local?.editChat ?? '',
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 10),
                  AddChatKeyboard(
                    defaultValue: _title,
                    onTyping: (val) {
                      _title = val;
                      _changeFABIcon(cubit);
                    },
                    pageLabel: local?.addPageLabel ?? '',
                  ),
                  _buildIconsTable(cubit, itemRowCount),
                ],
              ),
            ),
            floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, _) {
                final status = cubit.state.isFinished;
                return Align(
                  alignment: const Alignment(1, 0.87),
                  child: FloatingActionButton(
                    onPressed: () => _addOrEditChat(cubit, context),
                    child: Icon(_isEdit || status ? Icons.check : Icons.close),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconsTable(CreationCubit cubit, int itemRowCount) {
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
        itemCount: IconList.data.length,
        itemBuilder: (_, index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: ChatIcon(
              child: Icon(IconList.data[index]),
              index: index,
              pageIndex: cubit.state.index,
            ),
            onTap: () {
              cubit.changeIndex(index);
            },
          );
        },
      ),
    );
  }

  void _changeFABIcon(CreationCubit cubit) {
    if (_isEdit) return;

    final status = cubit.state.isFinished;
    if (_title.isNotEmpty && !status || _title.isEmpty && status) {
      cubit.changeFinishStatus(!status);
    }
  }

  void _addOrEditChat(CreationCubit creationCubit, BuildContext context) {
    if (_title.isNotEmpty) {
      final cubit = context.read<HomeCubit>();
      if (widget.chat == null) {
        cubit.add(
          title: _title,
          iconData: IconList.data[creationCubit.state.index],
        );
      } else {
        cubit.edit(
          widget.chat?.id ?? 0,
          title: _title,
          iconData: IconList.data[creationCubit.state.index],
        );
      }
    }

    creationCubit.reset();
    closePage(context);
  }
}
