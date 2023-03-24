import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/widgets/event_page/event_box.dart';
import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'search_cubit.dart';
import 'search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final local = AppLocalizations.of(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
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
                  controller: controller,
                  onChanged: cubit.lookForWords,
                  style: textTheme(context).bodyText2!,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        controller.clear();
                        cubit.lookForWords();
                      },
                    ),
                    hintText: local?.searchFieldHint ?? '',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: BlocProvider.of<SettingsCubit>(context).isDark
                          ? Colors.grey
                          : Colors.white,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          body: _buildListView(state, MediaQuery.of(context).size),
        );
      },
    );
  }

  ListView _buildListView(SearchState state, Size size) {
    final events = state.events;
    return ListView.builder(
      reverse: true,
      itemCount: events.length,
      itemBuilder: (_, i) {
        final index = events.length - 1 - i;
        return EventBox(
          event: events[index],
          size: size,
          isSelected: events[index].isSelected,
        );
      },
    );
  }
}
