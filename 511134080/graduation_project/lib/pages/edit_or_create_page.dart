import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubits/events_cubit.dart';
import 'package:graduation_project/models/chat_model.dart';

import '../constants.dart';

class CreatingPage extends StatefulWidget {
  const CreatingPage({
    Key? key,
    this.isCreatingNewPage = true,
    this.editingPage,
  }) : super(key: key);

  final bool isCreatingNewPage;
  final ChatModel? editingPage;

  @override
  State<CreatingPage> createState() => _CreatingPageState();
}

class _CreatingPageState extends State<CreatingPage> {
  var _isSelectedIcon = true;
  late int _selectedIndex;
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.isCreatingNewPage ? 0 : widget.editingPage!.iconId;
    if (!widget.isCreatingNewPage) _controller.text = widget.editingPage!.title;
    _focusNode.requestFocus();
  }

  Widget _createIconButton(index) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: _isSelectedIcon && index == _selectedIndex
            ? Border.all(width: 3, color: Colors.deepPurple)
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: IconButton(
        onPressed: () {
          if (!_isSelectedIcon) {
            setState(() {
              _selectedIndex = index;
              _isSelectedIcon = true;
            });
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        icon: index == 0 && _selectedIndex == 0 && _controller.text != ''
            ? Center(
                child: Text(
                  _controller.text[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              )
            : icons[index],
        color: Colors.blue,
      ),
    );
  }

  void _creatingPage() {
    if (_controller.text != '') {
      if (widget.isCreatingNewPage) {
        context.read<EventsCubit>().addChat(_selectedIndex, _controller.text);
        Navigator.pop(context);
      } else {
        context
            .read<EventsCubit>()
            .editChat(widget.editingPage?.id, _selectedIndex, _controller.text);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  Widget _createTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          onChanged: (_) {
            setState(() {});
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

  FloatingActionButton _createFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if (!_isSelectedIcon || _controller.text == '') {
          Navigator.pop(context);
        } else {
          _creatingPage();
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
                widget.isCreatingNewPage
                    ? 'Create a new Page'
                    : 'Edit the Page \'${widget.editingPage?.title}\'',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          _createTextField(),
          Expanded(
            flex: 10,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: icons.length,
                itemBuilder: (_, index) {
                  return _createIconButton(index);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _createFloatingActionButton(),
    );
  }
}
