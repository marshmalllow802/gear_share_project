import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:gear_share_project/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,

      ///Wyświetlanie loadera póki Authentication repository decyduje aby wyświetlić odpowiedni ekran
      home: const Scaffold(
        backgroundColor: KColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}