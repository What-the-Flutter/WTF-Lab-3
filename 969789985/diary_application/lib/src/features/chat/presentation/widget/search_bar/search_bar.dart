import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/icons.dart';
import '../../cubit/search_control/message_search_cubit.dart';

class SearchBar extends StatefulWidget {
  SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _searchFieldController;

  double _width = 60.0;

  @override
  void initState() {
    _searchFieldController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageSearchCubit, MessageSearchState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _width,
          curve: state.isSearchMode ? Curves.fastOutSlowIn : Curves.decelerate,
          child: Row(
            children: [
              _animatedSearchButton(context, state),
              _searchTextField(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _animatedSearchButton(
          BuildContext context, MessageSearchState state) =>
      AnimatedIconButton(
        duration: const Duration(milliseconds: 500),
        onPressed: () {
          if (!state.isSearchMode) {
            _width = MediaQuery.of(context).size.width * 0.8;
          } else {
            _width = 60.0;
          }
          context.read<MessageSearchCubit>().updateSearchMode();
          _searchFieldController.clear();
        },
        icons: [
          AnimatedIconItem(
            icon: Icon(
              Icons.search,
              size: IconsSize.standard,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          AnimatedIconItem(
            icon: Icon(
              Icons.close,
              size: IconsSize.standard,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ],
      );

  Widget _searchTextField(BuildContext context, MessageSearchState state) {
    return Visibility(
      visible: state.isSearchMode,
      child: Expanded(
        child: TextField(
          controller: _searchFieldController,
          autofocus: true,
          onChanged: (value) {
            context.read<MessageSearchCubit>().onQueryChanged(value);
          },
          decoration: const InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
              hintText: 'Search here...'),
        ),
      ),
    );
  }
}
