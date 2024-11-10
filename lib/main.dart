// import 'package:flutter/material.dart';
// import 'package:tierlist/app/app.dart';

// void main() {
//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/presentation/screens/menu_screen.dart';

void main() {
  runApp(const MenuScreenTestApp());
}

class MenuScreenTestApp extends StatelessWidget {
  const MenuScreenTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
