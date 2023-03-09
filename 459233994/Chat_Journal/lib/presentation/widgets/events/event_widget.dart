import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../../../../domain/entities/event.dart';
import '../../screens/chat/chat_cubit.dart';
import '../app_theme/inherited_app_theme.dart';

class EventWidget extends StatefulWidget {
  final Event _event;

  EventWidget({
    required event,
  })  : _event = event;

  @override
  State<EventWidget> createState() => _EventWidgetState(
        event: _event,
      );
}

class _EventWidgetState extends State<EventWidget> {
  Event _event;
  double _leftPositionValue = 10;
  final DateFormat formatter = DateFormat('Hm');
  final GlobalKey _widgetKey = GlobalKey();
  late BuildContext _buildContext;          //TODO check context

  _EventWidgetState({
    required event,
  })  : _event = event;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              padding: EdgeInsets.only(left: _leftPositionValue),
              child: GestureDetector(
                onHorizontalDragUpdate: _horizontalDragUpdateHandler,
                onHorizontalDragEnd: (details) {
                  _horizontalDragEndHandler(details, _buildContext);
                },
                onTap: _tapHandler,
                child: _messageContent(),
              ),
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
          color: InheritedAppTheme.of(context)?.getTheme.auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _categoryIcon(),
            Text(
              _event.textData!,
              softWrap: true,
              style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor,
                fontSize: 16,
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
          color: InheritedAppTheme.of(context)?.getTheme.auxiliaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
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
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              formatter.format(_event.createTime),
              style: TextStyle(
                color: InheritedAppTheme.of(context)?.getTheme.textColor,
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
                      color: InheritedAppTheme.of(context)?.getTheme.iconColor,
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
                    color: InheritedAppTheme.of(context)?.getTheme.iconColor,
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

  Widget _categoryIcon() {
    if (_event.category != null) {
      return Icon(
        _event.category,
        color: InheritedAppTheme.of(context)?.getTheme.iconColor,
      );
    } else {
      return Container(
        width: 0,
      );
    }
  }

  void _horizontalDragUpdateHandler(DragUpdateDetails details) {
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

  void _horizontalDragEndHandler(
    DragEndDetails details,
    BuildContext buildContext,
  ) {
    setState(
      () {
        if (_leftPositionValue >
            MediaQuery.of(context).size.width - _getMessageWidth() - 10) {
          var changedEvent = _event.isDone
              ? _event.updateDoneState(_event, false)
              : _event.updateDoneState(_event, true);
          ReadContext(context)
              .read<ChatCubit>()
              .editEvent(editedEvent: changedEvent);
          _event =
              ReadContext(context).read<ChatCubit>().getEventById(_event.id!);
        }
        _leftPositionValue = 10;
      },
    );
  }

  void _tapHandler() {
    setState(() {
      var changedEvent = _event.isFavorite
          ? _event.updateFavoriteState(_event, false)
          : _event.updateFavoriteState(_event, true);
      ReadContext(context)
          .read<ChatCubit>()
          .editEvent(editedEvent: changedEvent);
      _event = ReadContext(context).read<ChatCubit>().getEventById(_event.id!);
    });
  }
}
