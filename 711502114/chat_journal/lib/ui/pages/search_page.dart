import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/search/search_cubit.dart';
import '../../theme/colors.dart';
import '../widgets/event_page/event_box.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: messageBlocColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              controller: _controller,
              onChanged: (search) {
                setState(() {
                  BlocProvider.of<SearchCubit>(context).lookForWords(search);
                });
              },
              style: const TextStyle(fontSize: 18, color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      BlocProvider.of<SearchCubit>(context).lookForWords();
                    });
                  },
                ),
                hintText: AppLocalizations.of(context)?.searchFieldHint ?? '',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: secondaryMessageTextColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: _buildListView(context),
    );
  }

  ListView _buildListView(BuildContext context) {
    final events = BlocProvider.of<SearchCubit>(context).state.events;
    return ListView.builder(
      reverse: true,
      itemCount: events.length,
      itemBuilder: (_, i) {
        final index = events.length - 1 - i;
        return EventBox(
          event: events[index],
          size: MediaQuery.of(context).size,
          isSelected: events[index].isSelected,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
