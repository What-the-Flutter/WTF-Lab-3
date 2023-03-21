import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/models.dart';
import '../../settings_page/settings_cubit.dart';

class EventView extends StatefulWidget {
  final Event event;
  final Category? category;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const EventView({
    super.key,
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
  final _dateFormat = DateFormat('hh:mm');

  Widget _createEventSubtitle() {
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
            const Icon(
              Icons.bookmark,
              color: Colors.deepOrange,
              size: 15.0,
            ),
        ],
      ),
    );
  }

  Widget _createEventContent() {
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
    } else {
      eventContent = Text(widget.event.content!);
    }

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color:
              context.read<SettingsCubit>().state.themeData.colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            _createEventSubtitle(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: _createEventContent(),
        ),
      ],
    );
  }
}
