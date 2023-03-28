import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/date_card.dart';
import '../../widgets/drawer.dart';
import '../../widgets/event_card.dart';
import '../searching_page/searching_page.dart';
import '../settings/settings_cubit.dart';
import 'timeline_page_cubit.dart';

class TimelinePage extends StatelessWidget {
  TimelinePage({required BuildContext context, Key? key}) : super(key: key) {
    context.read<TimelinePageCubit>().init();
  }

  AppBar _appBar(BuildContext context, TimelinePageState state) => AppBar(
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
          _searchButton(context, state),
          _favouriteButton(context, state),
        ],
      );

  IconButton _searchButton(BuildContext context, TimelinePageState state) =>
      IconButton(
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

  IconButton _favouriteButton(BuildContext context, TimelinePageState state) =>
      IconButton(
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

  Widget _body(TimelinePageState state) => Column(
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
              cardModel: current,
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
                cardModel: current,
                key: UniqueKey(),
              ),
            ],
          ),
        );
      }
      return EventCard(
        cardModel: current,
        key: UniqueKey(),
      );
    }
  }

  Widget _floatingActionButton() => SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 16,
          child: const Icon(
            Icons.filter_list,
            size: 32,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TimelinePageCubit, TimelinePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context, state),
            drawer: const CustomDrawer(),
            floatingActionButton: _floatingActionButton(),
            body: _body(state),
          );
        },
      );
}
