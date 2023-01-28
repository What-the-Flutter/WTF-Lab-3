import 'package:flutter/material.dart';

import 'package:my_final_project/ui/widgets/timelime_screen/filter_labels.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_other.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_pages.dart';
import 'package:my_final_project/ui/widgets/timelime_screen/filter_tags.dart';

class FilterBody extends StatelessWidget {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Pages'),
    Tab(text: 'Tags'),
    Tab(text: 'Labels'),
    Tab(text: 'Others'),
  ];

  const FilterBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              labelText: 'Search',
            ),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                bottom: const TabBar(
                  tabs: myTabs,
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
