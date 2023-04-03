import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/event.dart';
import '../pages/chat/image_page.dart';
import '../pages/settings/settings_cubit.dart';

class EventCard extends StatelessWidget {
  final Event _cardModel;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool _shouldShowChatTitle;

  const EventCard({
    required Event cardModel,
    bool shouldShowChatTitle = false,
    this.onTap,
    this.onLongPress,
    required Key key,
  })  : _shouldShowChatTitle = shouldShowChatTitle,
        _cardModel = cardModel,
        super(key: key);

  Container _category(BuildContext context) => Container(
        child: _cardModel.categoryIndex != 0
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      allCategoryIcons[_cardModel.categoryIndex],
                      size: 32,
                      color: Colors.grey[
                          context.read<SettingsCubit>().state.isLight
                              ? 200
                              : 400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      allCategoryTitles[_cardModel.categoryIndex],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.grey[
                                context.read<SettingsCubit>().state.isLight
                                    ? 200
                                    : 400],
                          ),
                    ),
                  ),
                ],
              )
            : null,
      );

  Widget _eventTitle(BuildContext context) => Container(
        constraints: const BoxConstraints(
          maxWidth: 240,
        ),
        child: _cardModel.title.isNotEmpty
            ? HashTagText(
                text: _cardModel.title,
                basicStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.normal,
                    ),
                decoratedStyle:
                    Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: context.read<SettingsCubit>().state.isLight
                              ? Theme.of(context).primaryColorDark
                              : Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
              )
            : null,
      );

  Widget _eventImage(BuildContext context) => Container(
        child: _cardModel.imagePath != null
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImagePage(
                        imageSource: _cardModel.imagePath!,
                      ),
                    ),
                  );
                },
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 240,
                  ),
                  child: Image.network(
                    _cardModel.imagePath!,
                  ),
                ),
              )
            : null,
      );

  Widget _checkIconButton(BuildContext context) => Icon(
        Icons.check_circle,
        size: 16,
        color: _cardModel.isSelected
            ? Colors.black38
            : Theme.of(context).primaryColor.withAlpha(0),
      );

  Widget _eventTime(BuildContext context) => Text(
        DateFormat('hh:mm a').format(_cardModel.time),
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
            ),
      );

  Widget _bookmarkIconButton(BuildContext context) => Icon(
        Icons.bookmark,
        size: 16,
        color: _cardModel.isFavourite
            ? Colors.black38
            : Theme.of(context).primaryColor.withAlpha(0),
      );

  Widget _eventCardContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _eventTitle(context),
          const SizedBox(
            height: 5,
          ),
          _eventImage(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _checkIconButton(context),
              const SizedBox(
                width: 5,
              ),
              _eventTime(context),
              const SizedBox(
                width: 5,
              ),
              _bookmarkIconButton(context),
            ],
          ),
        ],
      );

  Widget _chatTitle(BuildContext context) => Container(
        child: _shouldShowChatTitle
            ? Text(
                _cardModel.chatTitle,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.grey[
                          context.read<SettingsCubit>().state.isLight
                              ? 600
                              : 400],
                    ),
              )
            : null,
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) => Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: state.isRightToLeft
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _cardModel.isSelected
                      ? Theme.of(context).focusColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(8),
                    topLeft: const Radius.circular(8),
                    bottomRight: state.isRightToLeft
                        ? const Radius.circular(0)
                        : const Radius.circular(8),
                    bottomLeft: state.isRightToLeft
                        ? const Radius.circular(8)
                        : const Radius.circular(0),
                  ),
                ),
                child: Column(
                  children: [
                    _chatTitle(context),
                    _category(context),
                    _eventCardContent(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
