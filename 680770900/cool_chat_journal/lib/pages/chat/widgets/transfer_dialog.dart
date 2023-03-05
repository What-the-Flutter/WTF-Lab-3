// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../cubit/chats_cubit.dart';
// import '../../../model/chats_state.dart';
// import '../../../themes/custom_theme.dart';

// class TransferDialog extends StatefulWidget {
//   const TransferDialog({super.key});

//   @override
//   State<TransferDialog> createState() => _TransferDialogState();
// }

// class _TransferDialogState extends State<TransferDialog> {
//   int? _selectedChat;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.all(40.0),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 30.0,
//           vertical: 20.0,
//         ),
//         color: CustomTheme.of(context).primaryColor,
//         child: Material(
//           type: MaterialType.transparency,
//           child: Column(
//             children: [
//               const Text('Select the page you want to migrate the selected '
//                   'event(s) to!'),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: BlocBuilder<ChatsCubit, ChatsState>(
//                   builder: (context, state) => ListView.builder(
//                     itemCount: state.chats.length,
//                     itemBuilder: (context, index) {
//                       return RadioListTile(
//                         title: Text(state.chats[index].name),
//                         activeColor: CustomTheme.of(context).backgroundColor,
//                         value: index,
//                         groupValue: _selectedChat,
//                         onChanged: (value) => setState(
//                           () => _selectedChat = value,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 40.0),
//                     decoration: BoxDecoration(
//                       color: CustomTheme.of(context).backgroundColor,
//                     ),
//                     child: TextButton(
//                       child: const Text('OK'),
//                       onPressed: () => Navigator.pop(context, _selectedChat),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 40.0),
//                     decoration: BoxDecoration(
//                       color: CustomTheme.of(context).backgroundColor,
//                     ),
//                     child: TextButton(
//                       child: const Text('Cancel'),
//                       onPressed: () => Navigator.pop(context, null),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
