import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_drawer.dart';
import '../../widgets/date_card.dart';
import '../../widgets/event_card.dart';
import '../filter_page/filter_page.dart';
import '../searching_page/searching_page.dart';
import '../settings/settings_cubit.dart';
import 'timeline_page_cubit.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  void initState() {
    super.initState();
    context.read<TimelinePageCubit>().init();
  }

  AppBar _appBar(TimelinePageState state) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        'Timeline',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
      ),
      actions: [
        _searchButton(state),
        _favouriteButton(state),
      ],
    );
  }

  IconButton _searchButton(TimelinePageState state) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchingPage(
              cards: state.allEvents,
              chatTitle: 'all pages',
              tags: state.tags,
              context: context,
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.search,
      ),
    );
  }

  IconButton _favouriteButton(TimelinePageState state) {
    return IconButton(
      onPressed: () {
        context.read<TimelinePageCubit>().toggleFavouriteMode();
      },
      icon: state.isShowingFavourites
          ? const Icon(
              Icons.bookmark,
            )
          : const Icon(
              Icons.bookmark_border_outlined,
            ),
    );
  }

  Widget _body(TimelinePageState state) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: ListView.builder(
            itemCount: state.eventsLength,
            reverse: true,
            itemBuilder: (_, index) => _listViewItem(index, state),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Widget _listViewItem(index, TimelinePageState state) {
    final events = state.events;

    final current = events.elementAt(index);

    if (events.length == 1 || index == events.length - 1) {
      return BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DateCard(date: current.time),
            EventCard(
              shouldShowChatTitle: true,
              event: current,
              key: UniqueKey(),
            )
          ],
        ),
      );
    } else {
      final next = events.elementAt(index + 1);
      if (DateFormat('dd-MM-yyyy').format(current.time) !=
          DateFormat('dd-MM-yyyy').format(next.time)) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateCard(date: current.time),
              EventCard(
                shouldShowChatTitle: true,
                event: current,
                key: UniqueKey(),
              ),
            ],
          ),
        );
      }
      return EventCard(
        shouldShowChatTitle: true,
        event: current,
        key: UniqueKey(),
      );
    }
  }

  Widget _hintMessage(TimelinePageState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.hintMessages[0],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
          ),
          Text(
            state.hintMessages[1],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        onPressed: () async {
          final events = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FilterPage(),
            ),
          );
          context.read<TimelinePageCubit>().updateEvents(events);
        },
        elevation: 16,
        child: const Icon(
          Icons.filter_list,
          size: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelinePageCubit, TimelinePageState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(state),
        drawer: const CustomDrawer(),
        body: state.events.isNotEmpty ? _body(state) : _hintMessage(state),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }
}
