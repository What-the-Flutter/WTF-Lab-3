import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../basic/providers/chat_list_provider.dart';
import 'screens/start_screen.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatListProvider>(
      create: (_) => ChatListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          primaryColorLight: const Color(0xFFf1eaea),
          primaryColorDark: Colors.grey[300]!,
          canvasColor: const Color(0x73f1eaea),
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xD9f5f5f5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFFf1eaea),
            elevation: 2,
            sizeConstraints:
                const BoxConstraints(minWidth: 90.0, minHeight: 90.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color(0xFFfdfdfd),
            surfaceTintColor: Color(0xFFfdfdfd),
          ),
          popupMenuTheme: PopupMenuThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation: 20,
            color: const Color(0xFFf1eaea),
          ),
          scaffoldBackgroundColor: const Color(0xFFfdfdfd),
          cardColor: const Color(0xFFf3efee),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
          ),
        ),
        home: const StartScreen(),
      ),
    );
  }
}
