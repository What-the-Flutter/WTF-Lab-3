import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/icon_map.dart';
import '../../domain/entities/tag.dart';
import '../../theme/colors.dart';
import '../../theme/themes.dart';
import '../pages/chat_page/chat_page_cubit.dart';
import '../pages/settings_page/settings_cubit.dart';

class ChatJournalSearch extends SearchDelegate {
  final ChatCubit chatCubit;
  final SettingsCubit settingsCubit;

  ChatJournalSearch({required this.chatCubit, required this.settingsCubit});

  TextTheme textTheme(BuildContext context) {
    final fontSize = context.read<SettingsCubit>().state.fontSize;
    switch (fontSize) {
      case 1:
        return Themes.largeTextTheme;
      case -1:
        return Themes.smallTextTheme;
      default:
        return Themes.normalTextTheme;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '' || context.watch<ChatCubit>().state.searchTags.isNotEmpty) {
      return Column(
        children: [
          _tagsPanel(context),
          Expanded(child: _showEvents(context)),
        ],
      );
    } else {
      return _enterQuery(context);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '' || context.watch<ChatCubit>().state.searchTags.isNotEmpty) {
      return Column(
        children: [
          _tagsPanel(context),
          Expanded(child: _showEvents(context)),
        ],
      );
    } else {
      return _enterQuery(context);
    }
  }

  Widget _tagsPanel(BuildContext context) {
    final tags = context.watch<ChatCubit>().state.tags;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      constraints: const BoxConstraints(maxHeight: 50),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return _tagItem(context, tags[index]);
        },
      ),
    );
  }

  Widget _tagItem(BuildContext context, Tag tag) {
    return GestureDetector(
      onTap: () => context.read<ChatCubit>().addOrRemoveSearchTag(tag),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: context.watch<ChatCubit>().state.searchTags.contains(tag.text)
              ? ChatJournalColors.lightRed
              : ChatJournalColors.lightGreen,
        ),
        child: Row(
          children: [
            context.watch<ChatCubit>().state.searchTags.contains(tag.text)
                ? const Icon(Icons.done)
                : Container(),
            Text(
              tag.text,
              style: textTheme(context).bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showEvents(BuildContext context) {
    final events = chatCubit.state.events;
    var results = <Event>[];
    if (query != '') {
      results = events
          .where(
              (event) => event.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    for (final tag in context.watch<ChatCubit>().state.searchTags) {
      results.addAll(events.where((element) => element.text.contains(tag)));
    }
    if (results.isNotEmpty) {
      return _allEvents(results);
    } else {
      return _noEvents(context);
    }
  }

  Widget _enterQuery(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _tagsPanel(context),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          decoration: BoxDecoration(
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                size: 50,
              ),
              Text(
                'Please enter a search query to begin searching',
                style: textTheme(context).bodyText2!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(),
      ],
    );
  }

  Widget _noEvents(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'No search results available',
                style: textTheme(context).bodyText2!,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'No entries match the given search query. Please try again',
                style: textTheme(context).bodyText2!,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(),
      ],
    );
  }

  Widget _allEvents(List<Event> events) {
    final eventCount = events.length;
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: eventCount,
            padding: EdgeInsets.zero,
            reverse: true,
            itemBuilder: (context, index) {
              return _event(events, eventCount - 1 - index, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _event(List<Event> events, int index, BuildContext context) {
    final eventColor = context.watch<SettingsCubit>().state.isLightTheme
        ? ChatJournalColors.lightGreen
        : ChatJournalColors.darkGrey;
    final selectedEventColor = context.watch<SettingsCubit>().state.isLightTheme
        ? ChatJournalColors.accentLightGreen
        : ChatJournalColors.lightGrey;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          _dateSeparator(events, index, context),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  color: events[index].isSelected
                      ? selectedEventColor
                      : eventColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _typeEvent(index, events, context),
                    _eventDate(index, events, context),
                  ],
                ),
              ),
              events[index].isFavorite
                  ? const Icon(Icons.bookmark)
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _typeEvent(int index, List<Event> events, BuildContext context) {
    if (events[index].imagePath == '') {
      if (events[index].iconIndex == 0) {
        return _messageEvent(index, events, context);
      } else {
        return _categoryEvent(index, events, context);
      }
    } else {
      return Image.file(File(events[index].imagePath));
    }
  }

  Widget _categoryEvent(int index, List<Event> events, BuildContext context) {
    final iconIndex = events[index].iconIndex;
    return Column(
      crossAxisAlignment: context.watch<SettingsCubit>().state.bubbleAlignment
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                ChatJournalIcons.eventIcons[iconIndex],
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                ChatJournalIcons.eventIconsName[iconIndex] ?? '',
                style: textTheme(context).bodyText1!,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _messageEvent(index, events, context),
      ],
    );
  }

  Widget _dateSeparator(List<Event> events, int index, BuildContext context) {
    final bool isOneDay;
    if (index != 0) {
      isOneDay = _isOneDay(events[index].dateTime, events[index - 1].dateTime);
    } else {
      isOneDay = false;
    }
    if (!isOneDay) {
      final textDate = _getTextDate(events[index].dateTime);
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? ChatJournalColors.lightRed
                : ChatJournalColors.lightGrey,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            textDate,
            style: textTheme(context).bodyText1!,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  bool _isOneDay(DateTime a, DateTime b) {
    if (a.day == b.day && a.month == b.month && a.year == b.year) {
      return true;
    } else {
      return false;
    }
  }

  String _getTextDate(DateTime date) {
    final difference = DateTime.now().difference(date).inHours;
    if (difference < 24) {
      return 'Today';
    }
    if (difference < 48) {
      return 'Yesterday';
    }
    if (difference < 72) {
      return '2 days ago';
    }
    if (difference < 96) {
      return '3 days ago';
    }
    if (difference < 120) {
      return '4days ago';
    }
    if (difference < 144) {
      return '5 days ago';
    }
    return DateFormat('MMM d, y').format(date);
  }

  Widget _messageEvent(int index, List<Event> events, BuildContext context) {
    return Text(
      events[index].text,
      style: textTheme(context).bodyText1!,
      textAlign: TextAlign.left,
    );
  }

  Widget _eventDate(int index, List<Event> events, BuildContext context) {
    return Text(
      DateFormat('h:mm a').format(events[index].dateTime),
      style: textTheme(context).bodyText1!.copyWith(
            color: Colors.grey,
          ),
      textAlign: TextAlign.left,
    );
  }
}
