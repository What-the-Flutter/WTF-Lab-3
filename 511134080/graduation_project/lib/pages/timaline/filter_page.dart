import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings/settings_cubit.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Search Query',
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.grey[
                                    context.read<SettingsCubit>().state.isLight
                                        ? 600
                                        : 300],
                              ),
                      filled: true,
                      fillColor: Colors.grey[
                          context.read<SettingsCubit>().state.isLight
                              ? 300
                              : 800],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                  padding: const EdgeInsets.all(8),
                  tabs: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tab(
                        text: 'Pages',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tab(
                        text: 'Tags',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tab(
                        text: 'Labels',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tab(
                        text: 'Others',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 40,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          color: Theme.of(context).hintColor,
                          child: Text(
                            'Tap to select a page you want to include to the '
                            'filter. All pages are included by default.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(
                            title: Text(
                              'Ignore selected pages',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            subtitle: Text(
                              'If enabled, the selected page(s) won\'t be displayed',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            trailing: Switch(
                              value: true,
                              onChanged: (_) {},
                              activeColor: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                        const Placeholder(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 40,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          color: Theme.of(context).hintColor,
                          child: Text(
                            'Tap to select a tag you want to include to the '
                            'filter. All tags are included by default.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                          ),
                        ),
                        const Placeholder(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 40,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          color: Theme.of(context).hintColor,
                          child: Text(
                            'Tap to select a label you want to include to the '
                            'filter. All labels are included by default.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                          ),
                        ),
                        const Placeholder(),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(
                            iconColor: Colors.grey[
                                context.read<SettingsCubit>().state.isLight
                                    ? 600
                                    : 300],
                            leading: const Icon(
                              Icons.event,
                            ),
                            title: Text(
                              'Jump to date',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            subtitle: Text(
                              'None(Experimental)',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListTile(
                            iconColor: Colors.grey[
                                context.read<SettingsCubit>().state.isLight
                                    ? 600
                                    : 300],
                            leading: const Icon(
                              Icons.check,
                            ),
                            title: Text(
                              'Ignore selected pages',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            subtitle: Text(
                              'If enabled, the selected page(s) won\'t be displayed',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            trailing: Switch(
                              value: false,
                              onChanged: (_) {},
                              activeColor: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: SizedBox(
            height: 64,
            width: 64,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 16,
              child: const Icon(
                Icons.check,
                size: 32,
              ),
            ),
          ),
        ),
      );
}
