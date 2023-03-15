import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/event.dart';
import '../../../domain/entities/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/themes.dart';
import '../settings_page/settings_cubit.dart';
import 'filter_cubit.dart';
import 'filter_state.dart';

class FilterPage extends StatelessWidget {
  final List<Event> events;
  final _controller = TextEditingController();

  FilterPage({required this.events, Key? key}) : super(key: key);

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
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return WillPopScope(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Filter',
                  style: textTheme(context).headline1,
                ),
                centerTitle: true,
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Pages'),
                    Tab(text: 'Tags'),
                    Tab(text: 'Labels'),
                    Tab(text: 'Other'),
                  ],
                ),
              ),
              body: _filterBody(state, context),
            ),
          ),
          onWillPop: () async {
            Navigator.of(context).pop(
              context.read<FilterCubit>().filterByChats(),
            );
            return false;
          },
        );
      },
    );
  }

  Widget _filterBody(FilterState state, BuildContext context) {
    return TabBarView(
      children: [
        _filterByPage(state, context),
        Container(),
        Container(),
        Container(),
      ],
    );
  }

  Widget _filterByPage(FilterState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Column(
            children: [
              _searchPanel(state, context),
              ..._switchPanel(state, context),
              _eventList(state, context),
            ],
          ),
          _floatingActionButton(context)
        ],
      ),
    );
  }

  List<Widget> _switchPanel(FilterState state, BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: context.watch<SettingsCubit>().state.isLightTheme
                ? ChatJournalColors.lightGreen
                : ChatJournalColors.darkGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(state.filterChats.isEmpty
              ? 'Tap to select a page you want to include to the filter.'
                  ' All pages are included by default'
              : '${state.filterChats.length} page(s) ${state.ignoreSelected ? 'ignored' : 'included'}'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ignore selected pages',
              style: textTheme(context).bodyText1,
            ),
            Switch(
              value: context.watch<FilterCubit>().state.ignoreSelected,
              onChanged: context.read<FilterCubit>().changeIgnoreSelected,
              activeColor: ChatJournalColors.accentYellow,
            ),
          ],
        ),
      ),
    ];
  }

  Widget _searchPanel(FilterState state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: context.watch<SettingsCubit>().state.isLightTheme
              ? Colors.grey[200]
              : ChatJournalColors.lightGrey),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventList(FilterState state, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 5,
          children: [
            for (final chat in state.chats)
              GestureDetector(
                onTap: () {
                  context.read<FilterCubit>().addOrRemoveFilter(chat.id);
                },
                child: UnconstrainedBox(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: state.filterChats.contains(chat.id)
                          ? ChatJournalColors.lightRed
                          : ChatJournalColors.lightGreen,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(ChatJournalIcons.chatIcons[chat.iconIndex]),
                        const SizedBox(
                          width: 1,
                        ),
                        Text(
                          chat.name,
                          style: textTheme(context).bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: const Icon(
          Icons.done,
          size: 30,
        ),
        onPressed: () async {
          Navigator.of(context).pop(context
              .read<FilterCubit>()
              .filterByChats(search: _controller.text));
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 20,
      bottom: 20,
    );
  }
}
