import 'package:flutter/material.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/app/dependency_injection.dart';
import 'package:tierlist/presentation/screens/menu_screen.dart';
import 'package:tierlist/presentation/screens/my_tier_lists_screen.dart';
import 'package:tierlist/presentation/screens/popular_list_screen.dart';
import 'package:tierlist/presentation/screens/popular_tier_lists_screen.dart';
import 'package:tierlist/presentation/screens/editor_screen.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MenuScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MenuScreen(),
        );

      case MyTierListsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MyTierListsScreen(),
        );

      case PopularTierListsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const PopularTierListsScreen(),
        );

      case EditorScreen.routeName:
        final tierList = settings.arguments as TierList?;

        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => getIt<EditorProvider>(param1: tierList),
            child: EditorScreen(),
          ),
        );

      case PopularListScreen.routeName:
        final tierList = settings.arguments as TierList;

        return MaterialPageRoute(
          builder: (_) => PopularListScreen(tierList: tierList),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
