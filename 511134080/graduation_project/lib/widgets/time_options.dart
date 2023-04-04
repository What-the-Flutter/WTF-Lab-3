import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class TimeOptions extends StatelessWidget {
  final String selectedOption;
  final bool isShowingOptions;
  final void Function({String? option}) onTap;

  const TimeOptions({
    required this.selectedOption,
    required this.isShowingOptions,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  String _generateTime(String timeOption) {
    if (timeOption == 'Today') {
      return DateFormat('MMM dd, yyyy').format(DateTime.now());
    } else if (timeOption == 'Past 7 days') {
      return '${DateFormat('MMM dd, yyyy').format(DateTime.now().subtract(const Duration(days: 7)))} -  ${DateFormat('MMM dd, yyyy').format(DateTime.now())}';
    } else if (timeOption == 'Past 30 days') {
      return '${DateFormat('MMM dd, yyyy').format(DateTime.now().subtract(const Duration(days: 30)))} -  ${DateFormat('MMM dd, yyyy').format(DateTime.now())}';
    } else if (timeOption == 'This year') {
      return DateFormat('yyyy').format(DateTime.now());
    }
    throw Exception('Invalid time option');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    selectedOption,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.deepPurple,
                        ),
                  ),
                  trailing: isShowingOptions
                      ? const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.deepPurple,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                  onTap: onTap,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: isShowingOptions ? 1 : 0,
          child: Container(
            height: isShowingOptions ? 100 : 1,
            child: isShowingOptions
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: timeOptions.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  timeOptions[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.deepPurple,
                                      ),
                                ),
                                subtitle: Text(
                                  _generateTime(timeOptions[index]),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context).disabledColor,
                                      ),
                                ),
                                onTap: () {
                                  onTap(option: timeOptions[index]);
                                },
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
