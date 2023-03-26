import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/event.dart';
import '../pages/chat/chat_cubit.dart';
import '../pages/settings/settings_cubit.dart';

class EventCard extends StatelessWidget {
  final Event _cardModel;

  const EventCard({
    required Event cardModel,
    required Key key,
  })  : _cardModel = cardModel,
        super(key: key);

  Container _createCategory(BuildContext context) {
    return Container(
      child: _cardModel.categoryIndex != 0
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    categoryIcons[_cardModel.categoryIndex],
                    size: 32,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoryTitle[_cardModel.categoryIndex],
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Widget _createEventCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxWidth: 240,
          ),
          child: _cardModel.title.isNotEmpty
              ? Text(
                  _cardModel.title,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.normal,
                      ),
                )
              : null,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: _cardModel.imagePath != null
              ? Container(
                  constraints: const BoxConstraints(
                    maxWidth: 240,
                  ),
                  child: Image.network(
                    _cardModel.imagePath!,
                  ),
                )
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: _cardModel.isSelected
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat('hh:mm a').format(_cardModel.time),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.8),
                  ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.bookmark,
              size: 16,
              color: _cardModel.isFavourite
                  ? Colors.black38
                  : Theme.of(context).primaryColor.withAlpha(0),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ChatCubit>().manageTapEvent(_cardModel);
      },
      onLongPress: () {
        context.read<ChatCubit>().manageLongPress(_cardModel);
      },
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Row(
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
                    Container(
                      child: _cardModel.categoryIndex != 0
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    categoryIcons[_cardModel.categoryIndex],
                                    size: 32,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    categoryTitle[_cardModel.categoryIndex],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : null,
                    ),
                    _createEventCardContent(context),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
