import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hashtager/widgets/hashtag_text.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/themes.dart';
import '../../pages/settings_page/settings_cubit.dart';
import '../filter_page/filter_page.dart';
import 'timeline_cubit.dart';
import 'timeline_state.dart';

class TimelinePage extends StatelessWidget {
  final _controller = TextEditingController();

  TimelinePage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                state.events.isEmpty
                    ? _chatWithNoEvents(state, context)
                    : Flexible(child: _chatWithEvents(state, context)),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
            _floatingActionButton(context, state),
          ],
        );
      },
    );
  }

  Widget _chatWithNoEvents(TimelineState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.lightGrey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                _chatWithNoEventsTitle(),
                style: textTheme(context).bodyText1!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                _chatWithNoEventsText(),
                style: textTheme(context).bodyText1!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _chatWithNoEventsTitle() => 'Your timeline is Empty';

  String _chatWithNoEventsText() =>
      'There are no events to be displayed on your timeline,'
      ' or you have filtered out all your pages in the filter menu';

  Widget _chatWithEvents(TimelineState state, BuildContext context) {
    return _allEvents(
        state, context, state.isFavoritesMode ? state.favorites : state.events);
  }

  Widget _allEvents(
      TimelineState state, BuildContext context, List<Event> events) {
    final eventCount = events.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: eventCount,
            reverse: true,
            itemBuilder: (context, index) {
              return _event(eventCount - 1 - index, events, state, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _event(int index, List<Event> events, TimelineState state,
      BuildContext context) {
    final timelineCubit = context.read<TimelineCubit>();
    final eventColor = context.watch<SettingsCubit>().state.isLightTheme
        ? ChatJournalColors.lightGreen
        : ChatJournalColors.darkGrey;
    final selectedEventColor = context.watch<SettingsCubit>().state.isLightTheme
        ? ChatJournalColors.accentLightGreen
        : ChatJournalColors.lightGrey;
    return Align(
      alignment: Alignment.bottomRight,
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            dismissalDuration: const Duration(milliseconds: 30),
            onDismissed: () => timelineCubit.deleteEvents(index),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => timelineCubit.deleteEvents(index),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            dismissalDuration: const Duration(milliseconds: 30),
            confirmDismiss: () async {
              _controller.text = state.events[index].text;
              timelineCubit.changeIsEditingState(value: true, index: index);
              return false;
            },
            closeOnCancel: true,
            onDismissed: () {},
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                _controller.text = state.events[index].text;
                timelineCubit.changeIsEditingState(value: true, index: index);
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).primaryColor,
              icon: Icons.edit,
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: () => timelineCubit.changeSelectedIndex(index),
          onTap: () => timelineCubit.onTapEvent(index),
          child: Column(
            children: [
              _dateSeparator(index, events, context),
              Row(
                mainAxisAlignment:
                    context.watch<SettingsCubit>().state.bubbleAlignment
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
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
                      color: state.events[index].isSelected
                          ? selectedEventColor
                          : eventColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          context.watch<SettingsCubit>().state.bubbleAlignment
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        _typeEvent(index, events, state, context),
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
        ),
      ),
    );
  }

  Widget _typeEvent(int index, List<Event> events, TimelineState state,
      BuildContext context) {
    if (events[index].imagePath != '') {
      return CachedNetworkImage(
        imageUrl: events[index].imagePath,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        ),
      );
    }
    if (events[index].iconIndex != 0) {
      return _categoryEvent(events[index], context);
    }
    return _messageEvent(events[index], context);
  }

  Widget _categoryEvent(Event event, BuildContext context) {
    final iconIndex = event.iconIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              HashTagText(
                text: ChatJournalIcons.eventIconsName[iconIndex] ?? '',
                basicStyle: textTheme(context).bodyText1!.copyWith(
                      color: context.watch<SettingsCubit>().state.isLightTheme
                          ? Colors.black
                          : Colors.white,
                    ),
                decoratedStyle:
                    textTheme(context).bodyText1!.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _messageEvent(event, context),
      ],
    );
  }

  Widget _dateSeparator(int index, List<Event> events, BuildContext context) {
    final bool isOneDay;
    if (index != 0) {
      isOneDay = _isOneDay(events[index].dateTime, events[index - 1].dateTime);
    } else {
      isOneDay = false;
    }
    if (!isOneDay) {
      final textDate = _getTextDate(events[index].dateTime);
      return Align(
        alignment: _dateAlignment(context),
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

  Alignment _dateAlignment(BuildContext context) {
    final state = context.watch<SettingsCubit>().state;
    if (state.centerDate) {
      return Alignment.center;
    }
    if (state.bubbleAlignment) {
      return Alignment.centerRight;
    }
    return Alignment.centerLeft;
  }

  bool _isOneDay(DateTime a, DateTime b) {
    if (a.day == b.day && a.month == b.month && a.year == b.year) {
      return true;
    } else {
      return false;
    }
  }

  String _getTextDate(DateTime date) {
    var otherDay = DateTime.now();
    final oneDay = const Duration(days: 1);
    final difference = otherDay.difference(date).inHours;
    if (difference < 24 && _isOneDay(otherDay, date)) {
      return 'Today';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 48 && _isOneDay(date, otherDay)) {
      return 'Yesterday';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 72 && _isOneDay(date, otherDay)) {
      return '2 days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 96 && _isOneDay(date, otherDay)) {
      return '3 days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 120 && _isOneDay(date, otherDay)) {
      return '4days ago';
    }
    otherDay = otherDay.subtract(oneDay);
    if (difference < 144 && _isOneDay(date, otherDay)) {
      return '5 days ago';
    }
    return DateFormat('MMM d, y').format(date);
  }

  Widget _messageEvent(Event event, BuildContext context) {
    return HashTagText(
      text: event.text,
      basicStyle: textTheme(context).bodyText1!.copyWith(
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? Colors.black
                : Colors.white,
          ),
      decoratedStyle:
          textTheme(context).bodyText1!.copyWith(color: Colors.blue),
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

  Widget _floatingActionButton(BuildContext context, TimelineState state) {
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: const Icon(
          Icons.filter_list,
          size: 30,
        ),
        onPressed: () async {
          final events = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FilterPage(
                events: state.events,
              ),
            ),
          );
          context.read<TimelineCubit>().changeEvents(events);
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 20,
      bottom: 20,
    );
  }
}
