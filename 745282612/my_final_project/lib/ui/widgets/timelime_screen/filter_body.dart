import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_labels.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_other.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_pages.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_tags.dart';

class FilterBody extends StatefulWidget {
  const FilterBody({super.key});

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  late final TextEditingController searchController;

  List<Tab> myTabs() {
    return <Tab>[
      Tab(text: S.of(context).pages),
      Tab(text: S.of(context).tags),
      Tab(text: S.of(context).labels),
      Tab(text: S.of(context).others),
    ];
  }

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              labelText: S.of(context).search,
            ),
            controller: searchController,
            onChanged: (value) => context.read<TimelineCubit>().searchText(value),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: myTabs().length,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  tabs: myTabs(),
                ),
              ),
              body: const TabBarView(
                children: [
                  FilterByPages(),
                  FilterByTags(),
                  FilterByLabels(),
                  FilterOther(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
