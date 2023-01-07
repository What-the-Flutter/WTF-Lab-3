import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/utils/insets.dart';
import '../cubit/manage_chat_cubit.dart';
import '../widgets/chat_icons.dart';

class ManageChatPage extends StatefulWidget {
  const ManageChatPage({
    super.key,
    this.forEdit,
  });

  final Chat? forEdit;

  @override
  State<ManageChatPage> createState() => _ManageChatPageState();
}

class _ManageChatPageState extends State<ManageChatPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.forEdit != null) {
      _textEditingController.text = widget.forEdit!.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageChatCubit(
        repository: RepositoryProvider.of<ChatRepository>(context),
        manageChatState: widget.forEdit == null
            ? const ManageChatAdding()
            : ManageChatEditing(chat: widget.forEdit!),
      ),
      child: BlocConsumer<ManageChatCubit, ManageChatState>(
        listener: (context, state) {
          if (state is ManageChatClosed) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state is ManageChatAdding ? 'Add Chat' : 'Edit Chat',
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Insets.large,
                    horizontal: Insets.large,
                  ),
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
                      counterText: '${_textEditingController.text.length}/30',
                    ),
                    onChanged: (value) {
                      context.read<ManageChatCubit>().onNameChanged(value);
                    },
                  ),
                ),
                const Expanded(
                  child: ChatIcons(),
                ),
              ],
            ),
            floatingActionButton: state.isFabShown
                ? FloatingActionButton(
                    child: Icon(
                      state is ManageChatAdding ? Icons.add : Icons.edit,
                    ),
                    onPressed: () {
                      context.read<ManageChatCubit>().onFabPressed();
                    },
                  )
                : null,
          );
        },
      ),
    );
  }
}
