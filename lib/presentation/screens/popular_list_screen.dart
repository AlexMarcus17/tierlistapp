import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/app/utils/utils.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:tierlist/presentation/screens/crop_image_screen.dart';
import 'package:tierlist/presentation/widgets/tier_list_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PopularListScreen extends StatefulWidget {
  TierList tierList;
  PopularListScreen({super.key, required this.tierList});
  static const String routeName = '/popularlist';

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  final SuperTooltipController toolTipController = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).black,
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
            child: SuperTooltip(
              showBarrier: true,
              content: const Text(
                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,",
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              controller: toolTipController,
              child: IconButton(
                color: Theme.of(context).white,
                icon: const Icon(Icons.info),
                onPressed: () async {
                  await toolTipController.showTooltip();
                },
              ),
            ),
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Theme.of(context).black,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...widget.tierList.tiers.asMap().entries.map(
                      (entry) {
                        final tierIndex = entry.key;
                        return buildTier(widget.tierList, tierIndex, context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            buildUncategorizedItems(widget.tierList, context),
          ],
        ),
      ),
    );
  }
}

Widget buildTier(TierList tierList, int tierIndex, BuildContext context) {
  final tier = tierList.tiers[tierIndex];
  final items = tierList.itemsMatrix[tierIndex];
  Color tierColor;
  switch (tierIndex) {
    case 0:
      tierColor = AppTheme.theme.sTier;
      break;
    case 1:
      tierColor = AppTheme.theme.aTier;
      break;
    case 2:
      tierColor = AppTheme.theme.bTier;
      break;
    case 3:
      tierColor = AppTheme.theme.cTier;
      break;
    case 4:
      tierColor = AppTheme.theme.dTier;
      break;
    default:
      tierColor = Colors.grey;
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 90,
              height: 80,
              color: tierColor,
              child: Center(
                child: Text(
                  tier.label ?? "Uncategorized",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((item) {
                    return buildDraggableItem(item, context);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildUncategorizedItems(TierList tierList, BuildContext context) {
  return Container(
    color: Theme.of(context).grey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        (tierList.uncategorizedItems.isEmpty)
            ? Container(
                height: 75,
                color: Theme.of(context).grey,
                width: double.infinity,
              )
            : ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 250,
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tierList.uncategorizedItems.map((item) {
                      return buildDraggableItem(item, context);
                    }).toList(),
                  ),
                ),
              ),
        Row(
          children: [
            Expanded(
              child: Container(height: 90, color: Theme.of(context).grey),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDraggableItem(TierListItem item, BuildContext context) {
  return Container(
    width: 75,
    height: 75,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 29, 86, 255),
      borderRadius: BorderRadius.circular(8),
    ),
    child: item is TierItemText
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Center(
              child: Text(
                item.text,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              (item as TierItemImage).imageFile,
              fit: BoxFit.cover,
            ),
          ),
  );
}
