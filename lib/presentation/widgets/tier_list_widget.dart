import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/data/models/tier_item.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TierListWidget extends StatefulWidget {
  final GlobalKey gkey;
  const TierListWidget(this.gkey, {super.key});
  @override
  State<TierListWidget> createState() => _TierListWidgetState();
}

class _TierListWidgetState extends State<TierListWidget> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<EditorProvider>(
      builder: (context, editorProvider, child) {
        final tierList = editorProvider.tierList;
        return Scaffold(
          backgroundColor: Theme.of(context).black,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: widget.gkey,
                    child: Column(
                      children: [
                        ...tierList.tiers.asMap().entries.map(
                          (entry) {
                            final tierIndex = entry.key;
                            return buildTier(
                                editorProvider, tierList, tierIndex);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildUncategorizedItems(editorProvider, tierList),
            ],
          ),
        );
      },
    );
  }

  Widget buildTier(EditorProvider provider, TierList tierList, int tierIndex) {
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

    return DragTarget<TierListItem>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (draggedItem) {
        if (draggedItem.data.tier == tier) {
          return;
        }
        provider.changeItemPlace(draggedItem.data, tierIndex, items.length);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 85,
                    height: 85,
                    color: tierColor,
                    child: Center(
                      child: Stack(
                        children: [
                          Text(
                            tier.label ?? "Uncategorized",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            tier.label ?? "Uncategorized",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: items.map((item) {
                          return buildDraggableItem(provider, item);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUncategorizedItems(EditorProvider provider, TierList tierList) {
    return DragTarget<TierListItem>(
      onWillAcceptWithDetails: (_) => true,
      onAcceptWithDetails: (draggedItem) {
        if (draggedItem.data.tier.label == null) {
          return;
        }
        provider.changeItemPlace(
            draggedItem.data, null, tierList.uncategorizedItems.length);
      },
      builder: (context, candidateData, rejectedData) {
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
                            return buildDraggableItem(provider, item);
                          }).toList(),
                        ),
                      ),
                    ),
              Row(
                children: [
                  Expanded(
                    child:
                        Container(height: 150, color: Theme.of(context).grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDraggableItem(EditorProvider provider, TierListItem item) {
    return Draggable<TierListItem>(
      data: item,
      feedback: Material(
        color: Colors.transparent,
        child: buildItemWidget(item, dragging: true),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: buildItemWidget(item),
      ),
      child: buildItemWidget(item),
    );
  }

  Widget buildItemWidget(TierListItem item, {bool dragging = false}) {
    return GestureDetector(
      onTap: dragging
          ? null
          : () {
              if (item is TierItemText) {
                textEditingController.text = item.text;
                showGeneralDialog(
                  barrierLabel: "",
                  barrierDismissible: true,
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    );
                  },
                  context: context,
                  pageBuilder: (ctx, _, __) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: FocusScope(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Center(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 300,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        border: Border.all(
                                            width: 3,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Edit Text Item",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Column(
                                              children: [
                                                TextField(
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      textEditingController,
                                                  maxLength: 20,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                    ),
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                const SizedBox(height: 10),
                                                ZoomTapAnimation(
                                                  onTap: () {
                                                    final text =
                                                        textEditingController
                                                            .text
                                                            .trim();
                                                    if (text.isNotEmpty) {
                                                      final editorProvider =
                                                          Provider.of<
                                                                  EditorProvider>(
                                                              context,
                                                              listen: false);
                                                      editorProvider
                                                          .changeItemTextById(
                                                              item.id, text);

                                                      textEditingController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 170,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    3)),
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                    child: Center(
                                                      child: Text(
                                                        "Save",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                ZoomTapAnimation(
                                                  onTap: () {
                                                    final editorProvider =
                                                        Provider.of<
                                                                EditorProvider>(
                                                            context,
                                                            listen: false);
                                                    editorProvider
                                                        .deleteItemById(
                                                            item.id);

                                                    textEditingController
                                                        .clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 170,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    3)),
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                    child: Center(
                                                      child: Text(
                                                        "Delete",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        textEditingController.clear();
                                        Navigator.of(context).pop();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SizedBox(
                                          height: 32,
                                          width: 32,
                                          child: Image.asset(
                                              "assets/images/close.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                showGeneralDialog(
                  barrierLabel: "",
                  barrierDismissible: true,
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: child,
                    );
                  },
                  context: context,
                  pageBuilder: (ctx, _, __) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 400,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    border: Border.all(
                                        width: 3,
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Image Item",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                child: ((item as TierItemImage)
                                                            .imageFile)
                                                        .startsWith(
                                                            "lib/data/sources/images/lists")
                                                    ? Image.asset(
                                                        (item).imageFile,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        File((item).imageFile),
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ZoomTapAnimation(
                                              onTap: () {
                                                final editorProvider =
                                                    Provider.of<EditorProvider>(
                                                        context,
                                                        listen: false);
                                                editorProvider
                                                    .deleteItemById(item.id);

                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 170,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(3)),
                                                    color: Theme.of(context)
                                                        .primaryColorDark),
                                                child: Center(
                                                  child: Text(
                                                    "Delete",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: Image.asset(
                                          "assets/images/close.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: dragging
              ? Theme.of(context).item.withOpacity(0.5)
              : Theme.of(context).item,
          borderRadius: BorderRadius.circular(8),
        ),
        child: item is TierItemText
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      item.text,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ((item as TierItemImage).imageFile)
                        .startsWith("lib/data/sources/images/lists")
                    ? Image.asset(
                        (item).imageFile,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File((item).imageFile),
                        fit: BoxFit.cover,
                      ),
              ),
      ),
    );
  }
}
