import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/chat.dart';

class BottomPanel extends StatefulWidget {
  final int chatIndex;
  final VoidCallback? resetSelection;
  final String? textFieldValue;
  final int? editEventIndex;

  const BottomPanel({
    required this.chatIndex,
    this.resetSelection,
    this.textFieldValue,
    this.editEventIndex,  
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _textFocusNode = FocusNode();
  final _textController = TextEditingController();

  Future<ImageSource?> _showImageDialog() {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text('Choose image source'), actions: [
        ElevatedButton(
          child: const Text('Camera'),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        ElevatedButton(
          child: const Text('Gallery'),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    );
  }

  void _onAddImage() async {
    final source= await _showImageDialog();

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        context.read<ChatsCubit>()
          .addNewImageEvent(widget.chatIndex, image.path);
      }
    }
  }

  void _onEnterText() {
    final editEventIndex = widget.editEventIndex;

    if (editEventIndex == null) {
      context.read<ChatsCubit>()
        .addNewTextEvent(widget.chatIndex, _textController.text);
    } else {
      context.read<ChatsCubit>()
        .editTextEvent(widget.chatIndex, editEventIndex, _textController.text);
    }

    widget.resetSelection?.call();

    _textFocusNode.unfocus();
    _textController.clear();
  }

  Widget _createMenuButton() {
    return IconButton(
      icon: const Icon(Icons.widgets_rounded),
      onPressed: () => {},
    );
  }

  Widget _createTextField() {
    return Expanded(
      child: _EventField(
        textFieldValue: widget.textFieldValue,
        focusNode: _textFocusNode,
        controller: _textController,
        onSubmitted: (_) => _onEnterText(),
      ),
    );
  }

  Widget _createSendButton() {
    if (_textController.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.send_rounded),
        onPressed: _onEnterText,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.add_a_photo_outlined),
        onPressed: _onAddImage,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.textFieldValue != null) {
      _textController.text = widget.textFieldValue!;
    }

    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _createMenuButton(),
        _createTextField(),
        _createSendButton(),
      ],
    );
  }
}

class _EventField extends StatelessWidget {
  final String? textFieldValue;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final void Function(String)? onSubmitted;

  const _EventField({
    this.textFieldValue,
    this.focusNode,
    required this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Enter event',
      ),
      onSubmitted: onSubmitted,
    );
  }
}
