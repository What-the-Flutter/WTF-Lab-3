import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/event.dart';
import '../../screens/chat/chat_cubit.dart';
import '../../screens/settings/settings_cubit.dart';
import '../app_theme/app_theme_cubit.dart';

class EventWidget extends StatefulWidget {
  final Event _event;
  final DateTime _previousEventSendTime;

  EventWidget({
    required event,
    required previousEventSendTime,
  })  : _event = event,
        _previousEventSendTime = previousEventSendTime;

  @override
  State<EventWidget> createState() => _EventWidgetState(
        event: _event,
      );
}

class _EventWidgetState extends State<EventWidget> {
  Event _event;
  double _leftPositionValue = 10;
  double _rightPositionValue = 10;
  late final double _screenSize;
  final DateFormat eventFormatter = DateFormat('Hm');
  final DateFormat dateBubbleFormatter = DateFormat('MMM d,y');
  final GlobalKey _widgetKey = GlobalKey();
  late BuildContext _buildContext; //TODO check context

  _EventWidgetState({
    required event,
  }) : _event = event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: ReadContext(context)
                  .read<SettingsCubit>()
                  .state
                  .isCenterDateBubble
              ? Alignment.center
              : (ReadContext(context)
                      .read<SettingsCubit>()
                      .state
                      .isRightBubbleAlignment
                  ? Alignment.centerRight
                  : Alignment.centerLeft),
          child: _dateBubble(),
        ),
        Row(
          mainAxisAlignment: ReadContext(context)
                  .read<SettingsCubit>()
                  .state
                  .isRightBubbleAlignment
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xff545F66),
                    size: 25,
                  ),
                ),
                Padding(
                  key: _widgetKey,
                  padding: ReadContext(context)
                          .read<SettingsCubit>()
                          .state
                          .isRightBubbleAlignment
                      ? EdgeInsets.only(right: _rightPositionValue)
                      : EdgeInsets.only(left: _leftPositionValue),
                  child: GestureDetector(
                    onHorizontalDragUpdate: _horizontalDragUpdateHandler,
                    onHorizontalDragEnd: (details) {
                      _horizontalDragEndHandler(details, _buildContext);
                    },
                    onTap: _tapHandler,
                    child: _messageContent(),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  double _getMessageWidth() {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return size.width;
  }

  Widget _messageContent() {
    if (_event.textData != null) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tags(),
            _categoryIcon(),
            Text(
              _event.textData!,
              softWrap: true,
              style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor,
                fontSize: ReadContext(context)
                    .read<SettingsCubit>()
                    .state
                    .fontSize
                    .toDouble(),
              ),
            ),
            _conditionString(),
          ],
        ),
      );
    } else if (_event.imageData != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _event.imageData!,
                  fit: BoxFit.contain,
                ),
              ),
              width: 100,
              height: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            _conditionString(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _conditionString() {
    return SizedBox(
      width: 75,
      height: 20,
      child: Align(
        alignment: ReadContext(context)
                .read<SettingsCubit>()
                .state
                .isRightBubbleAlignment
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              eventFormatter.format(_event.createTime),
              style: TextStyle(
                color: ReadContext(context)
                    .read<AppThemeCubit>()
                    .state
                    .customTheme
                    .textColor,
                fontSize: 12,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Builder(
                builder: (context) {
                  _buildContext = context;
                  if (_event.isDone) {
                    return Icon(
                      Icons.check,
                      color: ReadContext(context)
                          .read<AppThemeCubit>()
                          .state
                          .customTheme
                          .iconColor,
                      size: 14,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: (() {
                if (_event.isFavorite) {
                  return Icon(
                    Icons.bookmark,
                    color: ReadContext(context)
                        .read<AppThemeCubit>()
                        .state
                        .customTheme
                        .iconColor,
                    size: 14,
                  );
                }
              }()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tags() {
    if (_event.tags!.isNotEmpty) {
      var tags = _event.tags!.join(' ');
      return Text(
        tags,
        softWrap: true,
        style: TextStyle(
          color: ReadContext(context)
              .read<AppThemeCubit>()
              .state
              .customTheme
              .contrastColor,
          fontSize: 16,
        ),
      );
    } else {
      return Container(
        width: 0,
      );
    }
  }

  Widget _categoryIcon() {
    if (_event.category != null) {
      return Icon(
        _event.category,
        color: ReadContext(context)
            .read<AppThemeCubit>()
            .state
            .customTheme
            .iconColor,
      );
    } else {
      return Container(
        width: 0,
      );
    }
  }

  Widget _dateBubble() {
    if (dateBubbleFormatter.format(widget._previousEventSendTime) !=
        dateBubbleFormatter.format(_event.createTime)) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ReadContext(context)
                .read<AppThemeCubit>()
                .state
                .customTheme
                .actionColor,
          ),
          child: Text(
            dateBubbleFormatter.format(_event.createTime),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _horizontalDragUpdateHandler(DragUpdateDetails details) {
    if (ReadContext(context)
        .read<SettingsCubit>()
        .state
        .isRightBubbleAlignment) {
      setState(
        () {
          if (_rightPositionValue - details.delta.dx > 10 &&
              _rightPositionValue - details.delta.dx + _getMessageWidth() <
                  MediaQuery.of(context).size.width - 10) {
            _rightPositionValue -= details.delta.dx;
          }
        },
      );
    } else {
      setState(
        () {
          if (_leftPositionValue + details.delta.dx + _getMessageWidth() <
                  MediaQuery.of(context).size.width &&
              _leftPositionValue + details.delta.dx > 10) {
            _leftPositionValue += details.delta.dx;
          }
        },
      );
    }
  }

  void _horizontalDragEndHandler(
    DragEndDetails details,
    BuildContext buildContext,
  ) {
    ReadContext(context).read<SettingsCubit>().state.isRightBubbleAlignment
        ? setState(
            () {
              if (_rightPositionValue < _getMessageWidth() + 10) {
                final changedEvent = _event.isDone
                    ? _event.updateDoneState(_event, false)
                    : _event.updateDoneState(_event, true);
                ReadContext(context)
                    .read<ChatCubit>()
                    .editEvent(editedEvent: changedEvent);
                _event = ReadContext(context)
                    .read<ChatCubit>()
                    .getEventById(_event.id!);
              }
              _rightPositionValue = 10;
            },
          )
        : setState(
            () {
              if (_leftPositionValue >
                  MediaQuery.of(context).size.width - _getMessageWidth() - 10) {
                final changedEvent = _event.isDone
                    ? _event.updateDoneState(_event, false)
                    : _event.updateDoneState(_event, true);
                ReadContext(context)
                    .read<ChatCubit>()
                    .editEvent(editedEvent: changedEvent);
                _event = ReadContext(context)
                    .read<ChatCubit>()
                    .getEventById(_event.id!);
              }
              _leftPositionValue = 10;
            },
          );
  }

  void _tapHandler() {
    setState(() {
      final changedEvent = _event.isFavorite
          ? _event.updateFavoriteState(_event, false)
          : _event.updateFavoriteState(_event, true);
      ReadContext(context)
          .read<ChatCubit>()
          .editEvent(editedEvent: changedEvent);
      _event = ReadContext(context).read<ChatCubit>().getEventById(_event.id!);
    });
  }
}
