import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tag.dart';
import '../../screens/chat/chat_cubit.dart';
import '../app_theme/inherited_theme.dart';

class TagSort extends StatefulWidget {
  final List<String> pickedTags;

  TagSort({required this.pickedTags});

  @override
  State<TagSort> createState() => _TagSortState();
}

class _TagSortState extends State<TagSort> {
  late final List<Tag> _tags;
  late final List<bool> _activeTags = [];

  @override
  void initState() {
    super.initState();
    _tags = ReadContext(context).read<ChatCubit>().state.tags!;
    for (var index = 0; index < _tags.length; index++) {
      _activeTags.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: <Widget>[
          Text(
            'show tags',
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
          Wrap(
            direction: Axis.horizontal,
            children: _tags
                .asMap()
                .map((index, tag) =>
                    MapEntry(index, _tagBubble(tag.name, index)))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _tagBubble(String tag, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _activeTags[index]
                ? InheritedAppTheme.of(context)!.themeData.actionColor
                : Colors.grey,
          ),
          child: Text(
            tag,
            style: TextStyle(
                color: InheritedAppTheme.of(context)!.themeData.textColor),
          ),
        ),
        onTap: () {
          setState(() {
            _activeTags[index] = !_activeTags[index];
            _activeTags[index]
                ? widget.pickedTags.add(_tags[index].name)
                : widget.pickedTags.remove(_tags[index].name);
          });
        },
      ),
    );
  }
}
