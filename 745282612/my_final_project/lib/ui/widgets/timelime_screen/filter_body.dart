import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/cubit/timeline_cubit.dart';

import 'package:my_final_project/ui/widgets/timelime_screen/filter_labels.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_other.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_pages.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_tags.dart';

class FilterBody extends StatefulWidget {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Pages'),
    Tab(text: 'Tags'),
    Tab(text: 'Labels'),
    Tab(text: 'Others'),
  ];

  const FilterBody({super.key});

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  late final TextEditingController searchController;

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
            decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              labelText: 'Search',
            ),
            controller: searchController,
            onChanged: (value) => context.read<TimelineCubit>().searchText(value),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: FilterBody.myTabs.length,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                bottom: const TabBar(
                  tabs: FilterBody.myTabs,
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
