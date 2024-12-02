import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/data/models/tier.dart';
import 'package:tierlist/data/models/tier_item.dart';
import 'package:tierlist/data/models/tier_item_image.dart';
import 'package:tierlist/data/models/tier_item_text.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class TierListScreen extends StatefulWidget {
  @override
  _TierListScreenState createState() => _TierListScreenState();
}

class _TierListScreenState extends State<TierListScreen> {
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
                  child: Column(
                    children: [
                      ...tierList.tiers.asMap().entries.map(
                        (entry) {
                          final tierIndex = entry.key;
                          return buildTier(editorProvider, tierList, tierIndex);
                        },
                      ),
                    ],
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
    switch (tierIndex % 7) {
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
      case 5:
        tierColor = AppTheme.theme.eTier;
        break;
      case 6:
        tierColor = AppTheme.theme.fTier;
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
          color: Theme.of(context).black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              (tierList.uncategorizedItems.isEmpty)
                  ? Container(
                      height: 80,
                      color: Theme.of(context).black,
                      width: double.infinity,
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
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
                        Container(height: 150, color: Theme.of(context).black),
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
      child: buildItemWidget(item),
      feedback: Material(
        color: Colors.transparent,
        child: buildItemWidget(item, dragging: true),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: buildItemWidget(item),
      ),
    );
  }

  Widget buildItemWidget(TierListItem item, {bool dragging = false}) {
    return GestureDetector(
      onTap: dragging
          ? null
          : () {
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
                              height: 270,
                              width: 240,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  border: Border.all(
                                      width: 3,
                                      color:
                                          Theme.of(context).primaryColorLight),
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
                                        "Add Text Item",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Column(
                                        children: [
                                          TextField(
                                            controller: TextEditingController(),
                                            maxLength: 15,
                                            decoration: InputDecoration(
                                              hintText: "Enter text here",
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          ZoomTapAnimation(
                                            onTap: () {
                                              // final text = addtextcontroller
                                              //     .text
                                              //     .trim();
                                              // if (text.isNotEmpty) {
                                              //   final editorProvider =
                                              //       Provider.of<
                                              //               EditorProvider>(
                                              //           context,
                                              //           listen: false);
                                              //   editorProvider
                                              //       .addNewTextItem(text);

                                              //   addtextcontroller.clear();
                                              //   Navigator.pop(context);
                                              // }
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
                                                  "Save",
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
                                  //addtextcontroller.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child:
                                        Image.asset("assets/images/close.png"),
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
            },
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: dragging ? Colors.blue.withOpacity(0.5) : Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: item is TierItemText
              ? Text(
                  item.text,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              : Text(item.id),
        ),
      ),
    );
  }
}
