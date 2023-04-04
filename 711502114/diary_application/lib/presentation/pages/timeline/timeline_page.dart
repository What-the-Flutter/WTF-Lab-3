import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/chat/event_cubit.dart';
import 'package:diary_application/presentation/pages/chat/event_state.dart';
import 'package:diary_application/presentation/pages/filter/filter_page.dart';
import 'package:diary_application/presentation/pages/search/search_cubit.dart';
import 'package:diary_application/presentation/pages/search/search_page.dart';
import 'package:diary_application/presentation/widgets/event_page/event_box.dart';
import 'package:diary_application/presentation/widgets/event_page/info_box.dart';
import 'package:diary_application/presentation/widgets/event_page/tool_menu_icon.dart';
import 'package:diary_application/presentation/widgets/home_page/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final _bookMark = Icons.bookmark_border_outlined;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    BlocProvider.of<EventCubit>(context).initAll();
    final query = MediaQuery.of(context);
    final size = query.size;

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final cubit = context.read<EventCubit>();
        return Scaffold(
          appBar: _buildAppBar(cubit, local),
          drawer: MenuDrawer(local: local),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (cubit.events.isEmpty)
                const InfoBox(isTimeline: true)
              else
                _buildMessageList(size, cubit),
            ],
          ),
          floatingActionButton: _openFilterFAB(state),
        );
      },
    );
  }

  AppBar _buildAppBar(EventCubit cubit, AppLocalizations? local) {
    return AppBar(
      title: Text(
        local?.timelinePage ?? '',
        style: textTheme(context).headline2!,
      ),
      centerTitle: true,
      actions: _initAppBarTools(cubit),
    );
  }

  List<Widget> _initAppBarTools(EventCubit cubit) {
    return [
      ToolMenuIcon(
        icon: Icons.search,
        onPressed: () {
          openNewPage(
            context,
            BlocProvider(
              create: (_) => SearchCubit(cubit.events),
              child: const SearchPage(),
            ),
          );
        },
      ),
      ToolMenuIcon(
        icon: cubit.favoriteMode ? Icons.bookmark : _bookMark,
        color: cubit.favoriteMode ? Colors.yellow : null,
        onPressed: () {
          cubit.changeFavorite();
        },
      ),
    ];
  }

  Widget _buildMessageList(Size size, EventCubit cubit) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: cubit.filterEvents.length,
        itemBuilder: (_, i) {
          final index = cubit.filterEvents.length - 1 - i;
          return EventBox(
            event: cubit.filterEvents[index],
            size: size,
            isSelected: cubit.filterEvents[index].isSelected,
          );
        },
      ),
    );
  }

  Widget _openFilterFAB(EventState state) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_list),
      onPressed: () async {
        final events = await openNewPage(
          context,
          FilterPage(events: state.events),
        );
        context.read<EventCubit>().updateEvents(events);
      },
    );
  }
}
