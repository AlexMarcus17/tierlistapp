import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/screens/popular_list_screen.dart';

class PopularTierListCard extends StatelessWidget {
  final TierList tierList;

  const PopularTierListCard({super.key, required this.tierList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PopularListScreen.routeName, arguments: tierList);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF424242),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(tierList.imagePath, width: 100),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tierList.name,
                      style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            bool? shouldAdd = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Add to My Tier Lists',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                content: Text(
                                    'Are you sure you want to add this to My Tier Lists?',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (shouldAdd == true && context.mounted) {
                              bool added = await Provider.of<TierListsProvider>(
                                      context,
                                      listen: false)
                                  .addPopularTierList(tierList);
                              if (added && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: Text(
                                      'Tier List added to My Tier Lists!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                  ),
                                );
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: Text(
                                        'Tier List already exists in My Tier Lists!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      backgroundColor:
                                          Theme.of(context).primaryColorDark,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
