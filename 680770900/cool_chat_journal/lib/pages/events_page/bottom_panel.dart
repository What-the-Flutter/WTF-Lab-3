import 'package:flutter/material.dart';

class BottomPanel extends StatefulWidget {
  final void Function(String)? onSendText;
  final VoidCallback? onSendImage;
  final String? textFieldValue;

  const BottomPanel({
    this.onSendText,
    this.onSendImage,
    this.textFieldValue
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  final _textFocusNode = FocusNode();
  final _textController = TextEditingController();

  // on
  // private
  void _onEnterText() {
    var onSendText = widget.onSendText;

    if (onSendText != null) {
      onSendText(_textController.text);
    }

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
        onPressed: () => widget.onSendImage?.call(),
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
    this.onSubmitted
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