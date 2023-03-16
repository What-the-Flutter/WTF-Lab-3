import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/chat.dart';
import 'managing_page_cubit.dart';

class ManagingPage extends StatelessWidget {
  final Chat? _editingPage;

  final _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  ManagingPage({
    Key? key,
    Chat? editingPage,
  })  : _editingPage = editingPage,
        super(key: key);

  Widget _createIconButton(
      BuildContext context, int index, ManagingPageState state) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: index == state.selectedIndex
            ? Border.all(
                width: 3,
                color: Theme.of(context).primaryColorDark,
              )
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: IconButton(
        onPressed: () {
          context.read<ManagingPageCubit>().updateSelectedIcon(index);
        },
        icon: index == 0 && _controller.text != ''
            ? Center(
                child: Text(
                  state.inputText[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            : icons[index],
      ),
    );
  }

  Future<void> _managingPage(BuildContext context) async {
    await context
        .read<ManagingPageCubit>()
        .manageChat(_editingPage?.id, _controller.text);

    Navigator.pop(context, context.read<ManagingPageCubit>().state.chat);
  }

  Widget _createTextField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          onChanged: (value) {
            context.read<ManagingPageCubit>().updateInput(value);
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).disabledColor.withAlpha(24),
            hintText: 'Name of the Page',
          ),
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }

  FloatingActionButton _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (_controller.text == '') {
          Navigator.pop(context);
        } else {
          _managingPage(context);
        }
      },
      elevation: 16,
      child: _controller.text != ''
          ? const Icon(
              Icons.done,
              size: 32,
            )
          : const Icon(
              Icons.close,
              size: 32,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ManagingPageCubit>().initState(_editingPage);
    _controller.text = context.read<ManagingPageCubit>().state.inputText;
    _focusNode.requestFocus();

    return BlocBuilder<ManagingPageCubit, ManagingPageState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 64,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    state.title,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              _createTextField(context),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 24,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: icons.length,
                    itemBuilder: (_, index) {
                      return _createIconButton(context, index, state);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: _createFloatingActionButton(context),
        );
      },
    );
  }
}
