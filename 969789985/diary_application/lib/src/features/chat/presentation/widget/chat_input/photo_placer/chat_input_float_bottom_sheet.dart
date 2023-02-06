import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/message_input/message_input_cubit.dart';

class ChatInputFloatBottomSheet extends StatelessWidget {
  final BuildContext blocContext;

  const ChatInputFloatBottomSheet({
    super.key,
    required this.blocContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            borderRadius: BorderRadius.circular(Radii.appConstant),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    _pickImages(context, source: ImageSource.camera),
                icon: const Icon(Icons.camera_alt_outlined),
              ),
              const SizedBox(height: Insets.appConstantSmall),
              IconButton(
                onPressed: () => _pickImages(context),
                icon: const Icon(Icons.image),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages(BuildContext context, {ImageSource? source}) async {
    try {
      final images = List<XFile?>.empty(growable: true);
      if (source != null) {
        images.add(await ImagePicker().pickImage(source: source));
      } else {
        images.addAll(await ImagePicker().pickMultiImage());
      }

      if (images.contains(null)) return;

      blocContext.read<MessageInputCubit>().sendIcon = Icons.send.codePoint;
      blocContext.read<MessageInputCubit>().putImages(
            images.map((e) => e!.path).toList(),
          );
    } on PlatformException catch (e) {
      print('Platform exception: $e');
      Navigator.of(context).pop();
    }
  }
}
