import 'dart:io';

import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:diary_application/presentation/pages/search/search_cubit.dart';
import 'package:diary_application/presentation/pages/search/search_page.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/widgets/event_page/category_box.dart';
import 'package:diary_application/presentation/widgets/event_page/dismiss_item.dart';
import 'package:diary_application/presentation/widgets/event_page/event_box.dart';
import 'package:diary_application/presentation/widgets/event_page/event_keyboard.dart';
import 'package:diary_application/presentation/widgets/event_page/info_box.dart';
import 'package:diary_application/presentation/widgets/event_page/migration_events_dialog.dart';
import 'package:diary_application/presentation/widgets/event_page/tag_panel.dart';
import 'package:diary_application/presentation/widgets/event_page/tool_menu_icon.dart';
import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'event_cubit.dart';
import 'event_state.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final _bookMark = Icons.bookmark_border_outlined;
  late final TextEditingController _fieldText;
  late AppLocalizations? _local;

  @override
  void initState() {
    super.initState();
    _fieldText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventCubit>(context).init(widget.chat.id);
    _local = AppLocalizations.of(context);
    final query = MediaQuery.of(context);
    final size = query.size;

    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        final cubit = context.read<EventCubit>();
        return WillPopScope(
          onWillPop: () => _handleBackButton(cubit),
          child: Scaffold(
            appBar: _buildAppBar(cubit),
            body: Container(
              decoration:
                  context.watch<SettingsCubit>().state.backgroundImage != ''
                      ? BoxDecoration(
                          image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              context
                                  .watch<SettingsCubit>()
                                  .state
                                  .backgroundImage,
                            ),
                          ),
                        ))
                      : const BoxDecoration(),
              child: Stack(
                children: [
                  if (cubit.events.isEmpty)
                    InfoBox(mainTitle: widget.chat.title),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMessageList(size, cubit),
                      Column(
                        children: [
                          if (cubit.categoryMode && checkOrientation(context))
                            CategoryBox(setCategory: cubit.setCategory),
                          if (state.isHashTag)
                            TagPanel(
                              controller: _fieldText,
                              state: state,
                            ),
                          EventKeyboard(
                            width: size.width,
                            fieldText: _fieldText,
                            cubit: cubit,
                            update: updateChatLastEvent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(EventCubit cubit) {
    final selected = cubit.selectedMode;
    return AppBar(
      title: selected
          ? null
          : Text(widget.chat.title, style: textTheme(context).headline2!),
      centerTitle: !selected,
      leading: selected
          ? ToolMenuIcon(
              icon: Icons.close,
              onPressed: () {
                cubit.finishEditMode(fieldText: _fieldText);
                updateChatLastEvent();
              },
            )
          : null,
      actions: <Widget>[
        if (selected)
          ..._initEditAppBarTools(cubit)
        else
          ..._initUsualAppBarTools(cubit),
      ],
    );
  }

  List<Widget> _initUsualAppBarTools(EventCubit cubit) {
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

  List<Widget> _initEditAppBarTools(EventCubit cubit) {
    final pencil = cubit.state.selectedIndexes.length == 1 && !cubit.editMode;
    return [
      Expanded(
        child: Align(
          alignment: const Alignment(.1, .15),
          child: Text(
            '${cubit.state.selectedIndexes.length}',
            style: textTheme(context).headline1!,
          ),
        ),
      ),
      ...[
        if (!pencil) const ToolMenuIcon(),
        ToolMenuIcon(
          icon: Icons.transit_enterexit,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                final function = cubit.migrateEvents;
                return MigrationEventsDialog(handleClicking: function);
              },
            );
          },
        ),
        if (pencil)
          ToolMenuIcon(
            icon: Icons.edit,
            onPressed: () {
              cubit.startEditMode(_fieldText);
            },
          ),
      ],
      ToolMenuIcon(
        icon: Icons.copy,
        onPressed: () {
          cubit.copyText();
        },
      ),
      ToolMenuIcon(
        icon: _bookMark,
        onPressed: () {
          cubit.changeFavoriteStatus();
        },
      ),
      ToolMenuIcon(
        icon: Icons.delete,
        onPressed: () {
          updateChatLastEvent();
          cubit.deleteMessage();
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
          return _initEventItem(cubit, index, size);
        },
      ),
    );
  }

  Widget _initEventItem(EventCubit cubit, int index, Size size) {
    return Dismissible(
      key: UniqueKey(),
      background: DismissItem(
        color: editColor,
        icon: Icons.edit,
        xDirection: -0.8,
      ),
      secondaryBackground: DismissItem(
        color: deleteColor,
        icon: Icons.delete,
        xDirection: 0.85,
      ),
      onDismissed: (direction) {
        cubit.handleSelecting(index);

        if (direction == DismissDirection.startToEnd) {
          cubit.startEditMode(_fieldText);
        } else if (direction == DismissDirection.endToStart) {
          cubit.deleteMessage();
        }

        updateChatLastEvent();
      },
      child: InkWell(
        child: EventBox(
          event: cubit.filterEvents[index],
          size: size,
          isSelected: cubit.filterEvents[index].isSelected,
        ),
        onTap: () {
          if (!cubit.editMode && cubit.selectedMode) {
            cubit.handleSelecting(index);
          }
        },
        onLongPress: () {
          if (cubit.favoriteMode) {
            cubit.changeFavorite();
            return;
          }

          if (!cubit.editMode) {
            cubit.handleSelecting(index);
          }
        },
      ),
    );
  }

  Future<bool> _handleBackButton(EventCubit cubit) async {
    if (!cubit.selectedMode) {
      return true;
    } else {
      cubit.finishEditMode(fieldText: _fieldText);
      updateChatLastEvent();
      return false;
    }
  }

  void updateChatLastEvent() {
    BlocProvider.of<HomeCubit>(context, listen: false).update();
  }

  @override
  void dispose() {
    super.dispose();
    _fieldText.dispose();
  }
}
