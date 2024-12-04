import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';

class PopularTierListCard extends StatelessWidget {
  final TierList tierList;

  const PopularTierListCard({super.key, required this.tierList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //navigate to tier list screen
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(tierList.imagePath, width: 100),
            ),
            SizedBox(width: 16),
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
                                title: Text('Add to My Tier Lists'),
                                content: const Text(
                                    'Are you sure you want to add this to My Tier Lists?'),
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

                            if (shouldAdd == true) {}
                          },
                          icon: Icon(Icons.add)),
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
