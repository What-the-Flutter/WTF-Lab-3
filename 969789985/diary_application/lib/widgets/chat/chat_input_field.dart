import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../ui/utils/dimensions.dart';

class ChatInputField extends StatefulWidget {
  ChatInputField({
    super.key,
    required this.chatTextFieldController,
    required this.provider,
  });

  final TextEditingController chatTextFieldController;
  final ChatProvider provider;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final ImagePicker _picker = ImagePicker();
  late final List<String> _imageFileList;

  var _buttonRightModuleIcon = Icons.mic_rounded;
  var _scale = 1.0;

  @override
  void initState() {
    super.initState();

    _imageFileList = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _photoPlacer(),
          AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Radii.applicationConstant),
                topLeft: Radius.circular(Radii.applicationConstant),
              ),
              color: Theme.of(context).primaryColorLight,
            ),
            duration: const Duration(milliseconds: 200),
            child: TextField(
              controller: widget.chatTextFieldController,
              onChanged: (value) {
                if (widget.chatTextFieldController.text.isEmpty &&
                    _imageFileList.isEmpty) {
                  setState(() => _buttonRightModuleIcon = Icons.mic_rounded);
                } else if (widget.chatTextFieldController.text.isNotEmpty) {
                  setState(() => _buttonRightModuleIcon = Icons.send);
                }
              },
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Insets.applicationConstantLarge,
                  horizontal: Insets.applicationConstantMedium,
                ),
                prefixIcon: _prefixIcon(),
                suffixIcon: _suffixIcon(),
                hintText: 'Message',
              ),
            ),
          ),
        ],
      );

  Widget _prefixIcon() => Padding(
        padding: const EdgeInsets.only(left: Insets.small),
        child: SizedBox(
          width: 100.0,
          child: Row(
            children: [
              _attachButton(context),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.new_label_outlined),
              ),
            ],
          ),
        ),
      );

  Widget _suffixIcon() => Padding(
        padding: const EdgeInsets.only(right: Insets.medium),
        child: _animatedSendButton(),
      );

  Widget _attachButton(BuildContext context) => AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _scale,
        child: IconButton(
          onPressed: () => _showFloatBottomSheet(context),
          icon: const Icon(Icons.attach_file),
        ),
      );

  Widget _animatedSendButton() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: IconButton(
          key: ValueKey<String>(_buttonRightModuleIcon.toString()),
          icon: Icon(_buttonRightModuleIcon),
          onPressed: _sendMessage,
        ),
      );

  Widget _photoPlacer() => _imageFileList.isEmpty
      ? Container(height: Insets.none)
      : SizedBox(
          height: 200.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.medium),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _imageFileList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(Insets.small),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Insets.medium),
                    child: Image.file(
                      File(
                        _imageFileList[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );

  void _showFloatBottomSheet(BuildContext context) {
    setState(() => _scale = 0.0);

    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => Container(
        width: 60.0,
        height: 180.0,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Insets.small,
            right: Insets.large,
            bottom: 70.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Radii.applicationConstant),
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => _pickImages(source: ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
                const SizedBox(height: Insets.applicationConstantSmall),
                IconButton(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
          ),
        ),
      ),
    ).whenComplete(() => setState(() => _scale = 1.0));
  }

  Future _pickImages({ImageSource? source}) async {
    try {
      final images = List<XFile?>.empty(growable: true);
      if (source != null) {
        images.add(await ImagePicker().pickImage(source: source));
      } else {
        images.addAll(await ImagePicker().pickMultiImage());
      }
      if (images.contains(null)) return;
      setState(() {
        _buttonRightModuleIcon = Icons.send;
        _imageFileList.addAll(images.map((e) => e!.path));
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _sendMessage() => widget.chatTextFieldController.text.isNotEmpty ||
          _imageFileList.isNotEmpty
      ? {
          widget.provider.add(
            widget.provider.message.copyWith(
              id: widget.provider.messages.isEmpty
                  ? 0
                  : widget.provider.chat.messages.last.id + 1,
              messageText:
                  widget.chatTextFieldController.text.excludeEmptyLines(),
              images: _imageFileList.toIList(),
              sendDate: DateTime.now(),
            ),
          ),
          setState(() {
            widget.chatTextFieldController.clear();
            _buttonRightModuleIcon = Icons.mic_rounded;
            _imageFileList.clear();
          }),
        }
      : {};
}
