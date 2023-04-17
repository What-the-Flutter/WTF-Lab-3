import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_sort/image_sort.dart';
import '../widgets/add_sort/label_sort.dart';
import '../widgets/add_sort/page_sort.dart';
import '../widgets/add_sort/tag_sort.dart';
import '../widgets/app_theme/inherited_theme.dart';
import 'time_line/time_line_cubit.dart';

class AddSortScreen extends StatefulWidget {
  @override
  State<AddSortScreen> createState() => _AddSortScreenState();
}

class _AddSortScreenState extends State<AddSortScreen> {
  int _index = 0;
  final List<String> _excludeChatIds = [];
  final List<String> _pickedTags = [];
  CarouselController buttonCarouselController = CarouselController();

  late final List<Widget> _bodyWidgets;

  @override
  void initState() {
    super.initState();
    _bodyWidgets = [
      PageSort(excludeChatIds: _excludeChatIds),
      TagSort(pickedTags: _pickedTags),
      LabelSort(),
      ImageSort(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: <Widget>[
            _navigationBar(),
            _carousel(),
          ],
        ),
      ),
      backgroundColor: InheritedAppTheme.of(context)!.themeData.backgroundColor,
      floatingActionButton: _floatingActionButton(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: InheritedAppTheme.of(context)!.themeData.themeColor,
      iconTheme: IconThemeData(
        color: InheritedAppTheme.of(context)!.themeData.keyColor,
      ),
      centerTitle: true,
      title: Text(
        'Filter',
        style: TextStyle(
          color: InheritedAppTheme.of(context)!.themeData.keyColor,
        ),
      ),
    );
  }

  Widget _navigationBar() {
    return BottomNavigationBar(
      elevation: 1.0,
      currentIndex: _index,
      backgroundColor: Colors.transparent,
      selectedItemColor: InheritedAppTheme.of(context)!.themeData.iconColor,
      unselectedItemColor: InheritedAppTheme.of(context)!.themeData.iconColor,
      items: [
        BottomNavigationBarItem(
          icon: Text(
            'Pages',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text(
            'Tags',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text(
            'Labels',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text(
            'Images',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: '',
        ),
      ],
      onTap: (index) {
        setState(() => _index = index);
        buttonCarouselController.animateToPage(_index);
      },
    );
  }

  Widget _carousel() {
    return CarouselSlider.builder(
      itemCount: _bodyWidgets.length,
      itemBuilder: (context, itemIndex, pageViewIndex) =>
          _bodyWidgets[itemIndex],
      options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          initialPage: 0,
          onPageChanged: (index, reason) {
            setState(() {
              _index = index;
            });
          }),
      carouselController: buttonCarouselController,
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        _excludeChatIds.isNotEmpty
            ? ReadContext(context)
                .read<TimeLineCubit>()
                .removeEventsFromExcludedChats(_excludeChatIds)
            : await ReadContext(context).read<TimeLineCubit>().loadEvents();
        if (_pickedTags.isNotEmpty) {
          ReadContext(context)
              .read<TimeLineCubit>()
              .removeEventsWithoutTags(_pickedTags);
        }
        Navigator.pop(context);
      },
      backgroundColor: InheritedAppTheme.of(context)!.themeData.actionColor,
      child: Icon(
        Icons.check,
        color: InheritedAppTheme.of(context)!.themeData.iconColor,
      ),
    );
  }
}
