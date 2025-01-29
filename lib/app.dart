import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/theme/theme.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,

      ///Wyświetlanie loadera póki Authentication repository decyduje aby wyświetlić odpowiedni ekran
      home: Scaffold(
        backgroundColor: KColors.primary,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
