import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/routes/app_router.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/app/dependency_injection.dart';
import 'package:tierlist/presentation/screens/menu_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<TierListsProvider>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tier List Maker',
        theme: AppTheme.theme,
        initialRoute: MenuScreen.routeName,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
