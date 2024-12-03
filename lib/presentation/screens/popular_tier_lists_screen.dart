import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/app/utils/utils.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/widgets/popular_tier_list_card.dart';
import 'package:tierlist/presentation/widgets/tier_list_card.dart';

class PopularTierListsScreen extends StatelessWidget {
  const PopularTierListsScreen({super.key});

  static const String routeName = '/populartierlists';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          elevation: 20,
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: IconButton(
            color: Theme.of(context).white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
      body: Consumer<TierListsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.userTierLists.length,
            itemBuilder: (context, index) {
              final tierList = provider.userTierLists[index];
              return PopularTierListCard(tierList: tierList);
            },
          );
        },
      ),
    );
  }
}
