import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/chat.dart';
import 'managing_page_cubit.dart';

class ManagingPage extends StatefulWidget {
  final Chat? _editingPage;

  ManagingPage({
    Key? key,
    Chat? editingPage,
    required BuildContext context,
  })  : _editingPage = editingPage,
        super(key: key) {
    context.read<ManagingPageCubit>().initState(_editingPage);
  }

  @override
  State<ManagingPage> createState() => _ManagingPageState();
}

class _ManagingPageState extends State<ManagingPage> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  Widget _iconButton(int index, ManagingPageState state) {
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
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                ),
              )
            : icons[index],
      ),
    );
  }

  Future<void> _managingPage() async {
    await context
        .read<ManagingPageCubit>()
        .manageChat(widget._editingPage?.id, _controller.text);

    Navigator.pop(context);
  }

  Widget _textField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
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

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if (_controller.text == '') {
          Navigator.pop(context);
        } else {
          _managingPage();
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

  Widget _iconsGrid(ManagingPageState state) {
    return Expanded(
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
            return _iconButton(index, state);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                  ),
                ),
              ),
              _textField(),
              _iconsGrid(state),
            ],
          ),
          floatingActionButton: _floatingActionButton(),
        );
      },
    );
  }
}
