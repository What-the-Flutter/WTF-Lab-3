import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/models/category.dart';
import '../../../domain/models/event.dart';
import '../../../domain/utils/utils.dart';
import '../../../theme/colors.dart';

class EventBox extends StatelessWidget {
  final Event event;
  final Size size;
  final bool isSelected;

  EventBox({
    Key? key,
    required this.event,
    required this.size,
    required this.isSelected,
  }) : super(key: key);

  final _iconFavoriteColor = Colors.yellow;
  final _iconNonFavoriteColor = Colors.transparent;
  final _circular = const Radius.circular(25);

  @override
  Widget build(BuildContext context) {
    final category = event.category;
    final waitMessage = AppLocalizations.of(context)?.waitPls ?? '';
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          if (category != null) ...[
            _pinCategoryLabel(category),
            const SizedBox(height: 5),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (event.photoPath?.isEmpty ?? false)
                _messageContainer()
              else if (event.message.isEmpty)
                _attachContainer() ?? Text(waitMessage)
              else
                Column(
                  children: [
                    _messageContainer(size.width * .75, false),
                    _attachContainer(false) ?? Text(waitMessage),
                  ],
                ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Icon(
                    Icons.bookmark,
                    color: event.isFavorite
                        ? _iconFavoriteColor
                        : _iconNonFavoriteColor,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(formatDate(context, event.creationTime)),
                      Text(formatTime(event.creationTime)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messageContainer([double minWidth = 0.0, bool isUsualText = true]) {
    return Container(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: size.width * .75,
      ),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? circleMessageSelectedColor : circleMessageColor,
        borderRadius: BorderRadius.only(
          topLeft: _circular,
          topRight: _circular,
          bottomRight: isUsualText ? _circular : Radius.zero,
        ),
      ),
      child: Text(
        event.message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget? _attachContainer([bool isUsualAttach = true]) {
    if (event.photoPath != null && !event.photoPath!.contains('https://')) {
      return null;
    }
    return Container(
      constraints: BoxConstraints(minWidth: size.width * .75),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? circleMessageSelectedColor : circleMessageColor,
        borderRadius: BorderRadius.only(
          topLeft: isUsualAttach ? _circular : Radius.zero,
          topRight: isUsualAttach ? _circular : Radius.zero,
          bottomRight: _circular,
        ),
      ),
      child: SizedBox(
        child: CachedNetworkImage(
          imageUrl: event.photoPath ?? '',
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
        ),
        width: size.width * 0.3,
        height: size.height * 0.3,
      ),
    );
  }

  Widget _pinCategoryLabel(Category category) {
    return Row(
      children: [
        Text(category.title, style: const TextStyle(fontSize: 18)),
        SizedBox(width: size.width * .05),
        Icon(category.icon),
      ],
    );
  }
}
