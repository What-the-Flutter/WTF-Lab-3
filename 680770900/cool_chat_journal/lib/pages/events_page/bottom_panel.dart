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

  void handleEnterText() {
    var onSendText = widget.onSendText;

    if (onSendText != null) {
      onSendText(_textController.text);
    }

    _textFocusNode.unfocus();
    _textController.clear();
  }

  void handleChangeText() {
    setState(() {});
  }

  Widget buildMenuButton() {
    return IconButton(
      icon: const Icon(Icons.widgets_rounded),
      onPressed: () => {},
    );
  }

  Widget buildTextField() {
    return Expanded(
      child: _EventField(
        textFieldValue: widget.textFieldValue,
        focusNode: _textFocusNode,
        controller: _textController,
        onSubmitted: (_) => handleEnterText(),
      ),
    );
  }

  Widget buildSendButton() {
    if (_textController.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(Icons.send_rounded),
        onPressed: handleEnterText,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.add_a_photo_outlined),
        onPressed: () {
          if (widget.onSendImage != null) {
            widget.onSendImage!();
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.textFieldValue != null) {
      _textController.text = widget.textFieldValue!;
    }
    
    _textController.addListener(handleChangeText);
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
        buildMenuButton(),
        buildTextField(),
        buildSendButton(),
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

      decoration: const InputDecoration(
        hintText: 'Enter event',
        filled: true,
        fillColor: Colors.white, 
      ),

      onSubmitted: onSubmitted,
    );
  }

}