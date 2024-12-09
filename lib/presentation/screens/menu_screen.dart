import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tierlist/app/dependency_injection.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/app/utils/utils.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/screens/editor_screen.dart';
import 'package:tierlist/presentation/screens/my_tier_lists_screen.dart';
import 'package:tierlist/presentation/screens/popular_tier_lists_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Material(
          color: Colors.transparent,
          elevation: 20,
          clipBehavior: Clip.none,
          child: Image.asset(
            'assets/images/barlogo.png',
            height: 40,
            width: 200,
          ),
        ),
        actions: [
          Material(
            elevation: 30,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: IconButton(
              color: Theme.of(context).white,
              icon: const Icon(Icons.settings),
              onPressed: () {
                Utils.showSettings(context);
              },
            ),
          ),
        ],
      ),
      body: getIt<TierListsProvider>().isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: DottedBorder(
                        dashPattern: const [8, 6],
                        color: Theme.of(context).cTier,
                        strokeWidth: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(EditorScreen.routeName);
                          },
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).cTier,
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Add a new Tier List',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(MyTierListsScreen.routeName);
                    },
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: Theme.of(context).bTier, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: Theme.of(context).primaryColorDark,
                      elevation: 10,
                    ),
                    child: Text(
                      "📋 My Tier Lists",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(PopularTierListsScreen.routeName);
                    },
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: Theme.of(context).aTier, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: Theme.of(context).primaryColorDark,
                      elevation: 10,
                    ),
                    child: Text(
                      "🌟 Popular Tier Lists",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
