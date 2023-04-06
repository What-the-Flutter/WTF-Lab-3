import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/models.dart';
import '../../../data/models/theme_enums.dart';
import '../../../utils/custom_theme.dart';
import '../chat_cubit.dart';

class EventView extends StatefulWidget {
  final String? chatName;
  final Event event;
  final Category? category;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const EventView({
    super.key,
    this.chatName,
    required this.event,
    this.category,
    this.isSelected = false,
    this.onLongPress,
    this.onTap,
  });

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final _cubit = GetIt.I<ChatCubit>();
  final _dateFormat = DateFormat('hh:mm');

  Widget _eventSubtitle() {
    return UnconstrainedBox(
      child: Row(
        children: [
          if (widget.isSelected)
            const Icon(
              Icons.check_circle,
              size: 15.0,
            ),
          Text(
            _dateFormat.format(widget.event.changeTime),
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          if (widget.event.isFavorite)
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 2 * pi),
              curve: Curves.bounceOut,
              duration: const Duration(seconds: 2),
              builder: (_, angle, __) => Transform.rotate(
                angle: angle,
                child: const Icon(
                  Icons.bookmark,
                  color: Colors.deepOrange,
                  size: 15.0,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _eventContent({
    required BuildContext context,
  }) {
    final textStyle = CustomTheme.of(context).themeData.textTheme.bodyMedium!;

    final Widget eventContent;
    if (widget.event.image != null) {
      eventContent = Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.memory(
          widget.event.image!,
          width: 200.0,
          height: 200.0,
        ),
      );
    } else if (widget.event.content != null) {
      eventContent = HashTagText(
        text: widget.event.content!,
        basicStyle: textStyle,
        decoratedStyle: textStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      );
    } else {
      _cubit.readImage(widget.event);
      eventContent = const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: CustomTheme.of(context).themeData.colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.chatName != null)
              Text(
                widget.chatName!,
                style: const TextStyle(color: Colors.grey),
              ),
            if (widget.category != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconData(
                        widget.category!.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(widget.category!.title),
                  ],
                ),
              ),
            eventContent,
            const SizedBox(height: 10.0),
            _eventSubtitle(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AlignmentGeometry alignment;

    if (CustomTheme.of(context).bubbleAlignmentType.isLeft) {
      alignment = Alignment.bottomLeft;
    } else {
      alignment = Alignment.bottomRight;
    }

    return Align(
      alignment: alignment,
      child: _eventContent(context: context),
    );
  }
}
