import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../cubit/event/event_cubit.dart';
import '../../cubit/event/event_state.dart';
import '../../cubit/home/home_cubit.dart';
import '../../cubit/search/search_cubit.dart';
import '../../models/chat.dart';
import '../../utils/utils.dart';
import '../widgets/event_page/attach_dialog.dart';
import '../widgets/event_page/event_box.dart';
import '../widgets/event_page/event_keyboard.dart';
import '../widgets/event_page/info_box.dart';
import '../widgets/event_page/migration_events_dialog.dart';
import '../widgets/event_page/tool_menu_icon.dart';
import 'search_page.dart';

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
    BlocProvider.of<EventCubit>(context).init(widget.chat);
    _local = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _handleBackButton,
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          final cubit = context.read<EventCubit>();
          return Scaffold(
            appBar: _buildAppBar(cubit),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.chat.events.isNotEmpty
                      ? _buildMessageList(size, cubit)
                      : InfoBox(size: size, mainTitle: widget.chat.title),
                  EventKeyboard(
                    width: size.width,
                    fieldText: _fieldText,
                    fieldHint: _local?.enterFieldHint ?? '',
                    rightIcon: !cubit.editMode ? Icons.send : Icons.edit,
                    openDialog: _openDialog,
                    action: !cubit.editMode ? _sendEvent : _turnOffEditMode,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(EventCubit cubit) {
    final selected = cubit.selectedMode;
    return AppBar(
      title: selected ? null : Text(widget.chat.title),
      centerTitle: !selected,
      leading: selected
          ? ToolMenuIcon(
              icon: Icons.close,
              onPressed: () {
                cubit.disableSelect();
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
        icon: cubit.favorite ? Icons.bookmark : _bookMark,
        color: cubit.favorite ? Colors.yellow : null,
        onPressed: () {
          cubit.showFavorites();
        },
      ),
    ];
  }

  List<Widget> _initEditAppBarTools(EventCubit cubit) {
    return [
      Expanded(
        child: Align(
          alignment: const Alignment(.1, .15),
          child: Text(
            '${cubit.selectedItemIndexes.length}',
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
      if (cubit.selectedItemIndexes.length == 1 && !cubit.editMode) ...[
        _initMigrationIcon(cubit),
        ToolMenuIcon(
          icon: Icons.edit,
          onPressed: () {
            cubit.turnOnEditMode(_fieldText);
          },
        ),
      ] else ...[
        const ToolMenuIcon(),
        _initMigrationIcon(cubit),
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
          Provider.of<HomeCubit>(context, listen: false).update();
          cubit.deleteMessage();
        },
      ),
    ];
  }

  ToolMenuIcon _initMigrationIcon(EventCubit cubit) {
    return ToolMenuIcon(
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
    );
  }

  Widget _buildMessageList(Size size, EventCubit cubit) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: cubit.events.length,
        itemBuilder: (_, i) {
          final index = cubit.events.length - 1 - i;
          return InkWell(
            child: EventBox(
              event: cubit.events[index],
              size: size,
              isSelected: cubit.events[index].isSelected,
            ),
            onTap: () {
              if (!cubit.editMode && cubit.selectedMode) {
                cubit.handleSelecting(index);
              }
            },
            onLongPress: () {
              if (!cubit.editMode) {
                cubit.handleSelecting(index);
              }
            },
          );
        },
      ),
    );
  }

  void _openDialog() {
    AttachDialog(context, _local, _sendEvent).open();
  }

  void _sendEvent([String? path]) {
    if (_fieldText.text.isEmpty && path == null) return;

    BlocProvider.of<EventCubit>(context).addEvent(_fieldText.text, path);
    updateChatLastEvent();
    _fieldText.clear();
  }

  void _turnOffEditMode() {
    BlocProvider.of<EventCubit>(context).turnOffEditMode(_fieldText);

    updateChatLastEvent();
  }

  Future<bool> _handleBackButton() async {
    if (!BlocProvider.of<EventCubit>(context).selectedMode) {
      return true;
    } else {
      BlocProvider.of<EventCubit>(context).disableSelect();
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
