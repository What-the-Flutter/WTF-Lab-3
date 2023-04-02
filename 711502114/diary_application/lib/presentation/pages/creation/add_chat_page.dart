import 'dart:math' as math;

import 'package:diary_application/domain/models/category.dart';
import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/icons.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:diary_application/presentation/pages/home/home_state.dart';
import 'package:diary_application/presentation/widgets/add_chat_page/add_chat_keyboard.dart';
import 'package:diary_application/presentation/widgets/add_chat_page/chat_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'creation_cubit.dart';
import 'creation_state.dart';

class AddChatPage extends StatefulWidget {
  final Chat? editChat;
  final bool? isCategoryMode;

  const AddChatPage({
    Key? key,
    this.editChat,
    this.isCategoryMode,
  }) : super(key: key);

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage>
    with SingleTickerProviderStateMixin {
  String _title = '';
  bool _isExit = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    if (widget.editChat != null) {
      _title = widget.editChat?.title ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final orientation = MediaQuery.of(context).orientation;
    final itemRowCount = orientation == Orientation.portrait ? 4 : 8;

    return BlocBuilder<CreationCubit, CreationState>(
      builder: (context, state) {
        final cubit = context.read<CreationCubit>();
        if (!cubit.state.isEditMode && widget.editChat != null && !_isExit) {
          cubit.setEditDefault(
            index: widget.editChat?.iconNumber ?? 0,
            editMode: true,
          );
        }
        return WillPopScope(
          onWillPop: () async {
            _isExit = true;
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
                    height: orientation == Orientation.portrait ? 70 : 30,
                  ),
                  Text(
                    widget.isCategoryMode == true
                        ? local?.addNewCategory ?? ''
                        : widget.editChat == null
                            ? local?.addNewChat ?? ''
                            : local?.editChat ?? '',
                    style: textTheme(context).headline1!,
                  ),
                  const SizedBox(height: 10),
                  AddChatKeyboard(
                    defaultValue: _title,
                    onTyping: (val) {
                      _title = val;
                      _changeFABIcon(cubit);
                    },
                    pageLabel: widget.isCategoryMode == true
                        ? local?.addCategoryLabel ?? ''
                        : local?.addPageLabel ?? '',
                  ),
                  _buildIconsTable(cubit, itemRowCount),
                ],
              ),
            ),
            floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, _) {
                final status = cubit.state.isFinished;
                final isEdit = widget.editChat != null;
                return Align(
                  alignment: const Alignment(1, 0.87),
                  child: FloatingActionButton(
                    onPressed: () => _addOrEditChat(cubit, context),
                    child: Icon(isEdit || status ? Icons.check : Icons.close),
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
        itemCount: IconMap.data.length,
        itemBuilder: (_, index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AnimatedBuilder(
              builder: (context, child) {
                if (cubit.state.index != index) {
                  return child ?? const SizedBox();
                }
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              animation: _controller,
              child: ChatIcon(
                child: Icon(IconMap.data[index]),
                index: index,
                pageIndex: cubit.state.index,
              ),
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
    if (widget.editChat != null) return;

    final status = cubit.state.isFinished;
    if (_title.isNotEmpty && !status || _title.isEmpty && status) {
      cubit.changeFinishStatus(!status);
    }
  }

  void _addOrEditChat(CreationCubit creationCubit, BuildContext context) {
    if (_title.isNotEmpty) {
      final cubit = context.read<HomeCubit>();
      if (widget.editChat == null) {
        if (widget.isCategoryMode == true) {
          Category.list.add(Category(
            IconMap.data[creationCubit.state.index],
            _title,
          ));
        } else {
          cubit.add(
            title: _title,
            iconNumber: creationCubit.state.index,
          );
        }
      } else {
        cubit.edit(
          '${widget.editChat?.id}',
          title: _title,
          iconNumber: creationCubit.state.index,
        );
      }
    }

    _isExit = true;
    creationCubit.reset();
    closePage(context);
  }
}
