import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary_application/domain/models/category.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final state = context.watch<SettingsCubit>().state;
    final isRight = state.alignment;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          if (category != null) ...[
            _pinCategoryLabel(context, category, isRight),
            const SizedBox(height: 5),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isRight ? TextDirection.rtl : TextDirection.ltr,
            children: [
              if (isRight) const SizedBox(width: 10),
              if (event.photoPath?.isEmpty ?? false)
                _messageContainer(context, isRight)
              else if (event.message.isEmpty)
                _attachContainer(isRight) ?? Text(waitMessage)
              else
                Column(
                  children: [
                    _messageContainer(
                        context, isRight, size.width * .75, false),
                    _attachContainer(isRight, false) ?? Text(waitMessage),
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
                    crossAxisAlignment: !state.isCenter
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
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

  Widget _messageContainer(
    BuildContext context,
    bool isReverse, [
    double minWidth = 0.0,
    bool isUsualText = true,
  ]) {
    return Transform.scale(
      scaleX: isReverse ? -1 : 1,
      child: Container(
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
        child: Transform.scale(
          scaleX: isReverse ? -1 : 1,
          child: Text(
            event.message,
            style: textTheme(context).bodyText2!,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }

  Widget? _attachContainer(bool isReverse, [bool isUsualAttach = true]) {
    if (event.photoPath != null && !event.photoPath!.contains('https://')) {
      return null;
    }
    return Transform.scale(
      scaleX: isReverse ? -1 : 1,
      child: Container(
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
        child: Transform.scale(
          scaleX: isReverse ? -1 : 1,
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
        ),
      ),
    );
  }

  Widget _pinCategoryLabel(
    BuildContext context,
    Category category,
    bool isRight,
  ) {
    return Row(
      textDirection: isRight ? TextDirection.rtl : TextDirection.ltr,
      children: [
        if (isRight) const SizedBox(width: 10),
        Text(category.title, style: textTheme(context).bodyText2!),
        SizedBox(width: size.width * .05),
        Icon(category.icon),
      ],
    );
  }
}
