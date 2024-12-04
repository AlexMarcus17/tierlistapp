// import 'package:flutter/material.dart';
// import 'package:tierlist/app/app.dart';

// void main() {
//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/data/sources/popular_tier_lists.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/screens/editor_screen.dart';
import 'package:tierlist/presentation/screens/menu_screen.dart';
import 'package:tierlist/presentation/screens/my_tier_lists_screen.dart';
import 'package:tierlist/presentation/screens/popular_list_screen.dart';
import 'package:tierlist/presentation/screens/popular_tier_lists_screen.dart';

void main() {
  runApp(const MenuScreenTestApp());
}

class MenuScreenTestApp extends StatelessWidget {
  const MenuScreenTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TierListsProvider();
      },
      child: MaterialApp(
        theme: AppTheme.theme,
        home: MenuScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
