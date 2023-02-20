import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/repository/chat/chat_repository.dart';
import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/util/resources/dimensions.dart';
import '../../../core/util/resources/icons.dart';
import '../theme/theme_scope.dart';
import 'chatter_main/chatter_list_item/chatter_card.dart';

//TODO #1: Cubit state control
//TODO #2: Animated toggle icon in chat card example
class ChatVariation extends StatefulWidget {
  final ChatModel chat;
  final bool isEditMode;

  ChatVariation({
    super.key,
    required this.chat,
    required this.isEditMode,
  });

  @override
  State<StatefulWidget> createState() => _ChatVariationState();
}

class _ChatVariationState extends State<ChatVariation>
    with SingleTickerProviderStateMixin {
  final TextEditingController _chatTitleInputFieldController =
      TextEditingController();

  late final Map<int, bool> _selectedIcon = {0: true};

  var _chatTitle = '';
  var _chatIcon = Icons.chat;
  var _scale = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.chat.chatTitle.isNotEmpty) {
      _chatTitle = widget.chat.chatTitle;
      _chatIcon = IconData(widget.chat.chatIcon, fontFamily: AppIcons.material);
    }

    _chatTitleInputFieldController.text = widget.chat.chatTitle;

    Future.delayed(
      Duration.zero,
      () => _systemNavBarColor(Theme.of(context).scaffoldBackgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _systemNavBarColor(
              Color(ThemeScope.of(context).state.primaryColor),
            );
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: _addChatButton(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _chatExample(),
            const SizedBox(height: Insets.appConstantSmall),
            _chatTitleInputField(),
            const SizedBox(height: Insets.appConstantSmall),
            _iconsBox(),
            const SizedBox(height: Insets.small),
          ],
        ),
      ),
    );
  }

  Widget _chatTitleInputField() {
    return Padding(
      padding: const EdgeInsets.only(
        right: Insets.appConstantSmall,
        left: Insets.appConstantSmall,
      ),
      child: TextField(
        controller: _chatTitleInputFieldController,
        maxLength: 15,
        autofocus: widget.isEditMode,
        onChanged: (value) {
          _chatTitle = value;
          setState(() {
            if (value.isEmpty) {
              _scale = 0.0;
            } else {
              _scale = 1.0;
            }
          });
        },
        decoration: InputDecoration(
          label: const Text('Chat title'),
          labelStyle: TextStyle(
            color: Theme.of(context).indicatorColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Insets.extraLarge * 0.8,
            horizontal: Insets.large,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radii.large),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Radii.large),
            borderSide: BorderSide(
              color: Theme.of(context).indicatorColor,
              width: Insets.extraSmall,
            ),
          ),
          prefixIcon: const Icon(Icons.title),
          suffixIcon: _suffixIcon(),
        ),
      ),
    );
  }

  Widget _suffixIcon() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _scale,
      child: Padding(
        padding: const EdgeInsets.only(right: Insets.small),
        child: IconButton(
          onPressed: () {
            setState(
              () {
                _scale = 0.0;
                _chatTitleInputFieldController.clear();
                _chatTitle = '';
              },
            );
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  Widget _chatExample() => ChatterCard(
        chat: ChatModel(
          id: widget.chat.id,
          chatTitle: _chatTitle,
          chatIcon: _chatIcon.codePoint,
          messages: IList(),
        ),
        isActionsVisible: widget.chat.chatTitle == '' ? false : true,
      );

  Widget _addChatButton() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _scale,
      child: FloatingActionButton(
        backgroundColor: Color(ThemeScope.of(context).state.primaryColor),
        onPressed: () {
          if (!widget.isEditMode) {
            RepositoryProvider.of<ChatRepository>(context).add(
              ChatModel(
                chatTitle: _chatTitleInputFieldController.text,
                chatIcon: _chatIcon.codePoint,
                messages: IList(),
              ),
            );

            _systemNavBarColor(
              Color(
                ThemeScope.of(context).state.primaryColor,
              ),
            );

            Navigator.pop(context);
          } else {
            RepositoryProvider.of<ChatRepository>(context).update(
              widget.chat.copyWith(
                  chatTitle: _chatTitleInputFieldController.text,
                  chatIcon: _chatIcon.codePoint),
            );

            _systemNavBarColor(
              Color(
                ThemeScope.of(context).state.primaryColor,
              ),
            );

            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _iconsBox() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          right: Insets.appConstantMedium,
          left: Insets.appConstantMedium,
        ),
        child: GridView.count(
          crossAxisCount: 5,
          children: [
            for (var index = 0; index < possibleIcons.length; index++)
              Padding(
                padding: const EdgeInsets.only(right: Insets.medium),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    _selectableIcon(index),
                    Container(
                      width: 20.0,
                      height: 20.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                          left: 30.0,
                        ),
                        child: _selectCheckbox(index),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _selectableIcon(int index) {
    return Container(
      width: 64.0,
      height: 64.0,
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(ThemeScope.of(context).state.primaryItemColor),
          ),
        ),
        onPressed: () {
          _selectedIcon.updateAll((_, value) => false);

          setState(() {
            _selectedIcon.containsKey(index)
                ? _selectedIcon.update(index, (value) => !_selectedIcon[index]!)
                : _selectedIcon.addAll({index: true});

            _chatIcon = IconData(
              possibleIcons[index],
              fontFamily: AppIcons.material,
            );
          });
        },
        icon: Icon(
          IconData(
            possibleIcons[index],
            fontFamily: AppIcons.material,
          ),
          size: IconsSize.large,
        ),
      ),
    );
  }

  Widget _selectCheckbox(int index) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.appConstant),
      ),
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide.none),
      activeColor: Colors.transparent,
      checkColor: Theme.of(context).indicatorColor,
      value: _selectedIcon.containsKey(index) ? _selectedIcon[index] : false,
      onChanged: (value) {},
    );
  }

  void _systemNavBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: color),
    );
  }
}
