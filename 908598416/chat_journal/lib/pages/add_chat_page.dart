import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class AddChat extends StatefulWidget {
  const AddChat({
    super.key,
  });

  @override
  State<AddChat> createState() => _AddChat();
}

class _AddChat extends State<AddChat> {
  late TextEditingController _chatNameController;

  @override
  void initState() {
    super.initState();
    _chatNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            size: 30, color: ColorConstants.greyColor),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Create New Chat',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _chatNameController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
