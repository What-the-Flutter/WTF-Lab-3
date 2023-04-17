import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/app_theme/inherited_theme.dart';
import '../../widgets/events/event_list.dart';
import '../add_sort.dart';
import '../chat/chat_search_cubit..dart';
import '../chat/chat_search_state.dart';
import 'time_line_cubit.dart';
import 'time_line_state.dart';

class TimeLine extends StatefulWidget {
  final String title = 'TimeLine';

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  void initState() {
    super.initState();
    ReadContext(context).read<TimeLineCubit>().loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeLineCubit, TimeLineState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Builder(
                builder: (context) {
                  if (state.isSearched == true) {
                    return _textField();
                  } else {
                    return Text(
                      widget.title,
                      style: TextStyle(
                        color:
                            InheritedAppTheme.of(context)!.themeData.keyColor,
                      ),
                    );
                  }
                },
              ),
            ),
            actions: _actionAppbarButtons(),
            backgroundColor:
                InheritedAppTheme.of(context)!.themeData.themeColor,
          ),
          body: Builder(
            builder: (context) {
              if (state.isLoaded) {
                return Column(
                  children: <Widget>[
                    BlocBuilder<ChatSearchCubit, ChatSearchState>(
                      builder: (context, searchState) {
                        if (searchState.isSearched == false) {
                          return EventList(
                            events: ReadContext(context)
                                .read<TimeLineCubit>()
                                .getEvents(),
                            isFavoritesMode: state.isFavorite,
                          );
                        } else if (searchState.isSearched == true) {
                          return searchState.events!.isNotEmpty
                              ? EventList(
                            events: searchState.events,
                            isFavoritesMode:
                            state.isFavorite,
                          )
                              : Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/empty_box.json',
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 300,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No such events'),
                                ),
                              ],
                            ),
                          );
                        }
                        return Expanded(
                          child: Container(),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          floatingActionButton: _floatingActionButton(),
        );
      },
    );
  }

  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: InheritedAppTheme.of(context)!.themeData.backgroundColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: InheritedAppTheme.of(context)!.themeData.textColor,
            ),
          ),
          hintText: 'Search',
        ),
        onSubmitted: (value) => {
          ReadContext(context).read<ChatSearchCubit>().searchEvents(
                value,
                ReadContext(context).read<TimeLineCubit>().getEvents(),
              ),
        },
      ),
    );
  }

  List<Widget> _actionAppbarButtons() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.search,
            color: InheritedAppTheme.of(context)!.themeData.keyColor,
          ),
          onTap: () =>
              ReadContext(context).read<TimeLineCubit>().changeSearchedState(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(
            Icons.bookmark_border_outlined,
            color: InheritedAppTheme.of(context)!.themeData.keyColor,
          ),
          onTap: () =>
              ReadContext(context).read<TimeLineCubit>().changeFavoriteState(),
        ),
      ),
    ];
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: InheritedAppTheme.of(context)!.themeData.actionColor,
      onPressed: _addSort,
      child: Icon(
        Icons.sort,
        color: InheritedAppTheme.of(context)!.themeData.iconColor,
      ),
    );
  }

  Future<void> _addSort() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSortScreen(),
      ),
    );
  }
}
