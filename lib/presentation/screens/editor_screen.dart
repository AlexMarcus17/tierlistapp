import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tierlist/app/theme/app_theme.dart';
import 'package:tierlist/app/utils/utils.dart';
import 'package:tierlist/presentation/providers/editor_provider.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:tierlist/presentation/screens/crop_image_screen.dart';
import 'package:tierlist/presentation/widgets/tier_list_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});
  static const String routeName = '/editor';

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final GlobalKey repaintBoundaryKey = GlobalKey();

  Future<Uint8List?> captureTierList() async {
    try {
      final boundary = repaintBoundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 6.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData!.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  final TextEditingController addtextcontroller = TextEditingController();

  late TextEditingController tier1controller;

  late TextEditingController tier2controller;

  late TextEditingController tier3controller;

  late TextEditingController tier4controller;

  late TextEditingController tier5controller;

  @override
  void initState() {
    super.initState();

    tier1controller = TextEditingController();
    tier2controller = TextEditingController();
    tier3controller = TextEditingController();
    tier4controller = TextEditingController();
    tier5controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<EditorProvider>(context, listen: false);
    tier1controller.text = provider.tierList.tiers[0].label ?? "S";
    tier2controller.text = provider.tierList.tiers[1].label ?? "A";
    tier3controller.text = provider.tierList.tiers[2].label ?? "B";
    tier4controller.text = provider.tierList.tiers[3].label ?? "C";
    tier5controller.text = provider.tierList.tiers[4].label ?? "D";
  }

  @override
  void dispose() {
    addtextcontroller.dispose();
    tier1controller.dispose();
    tier2controller.dispose();
    tier3controller.dispose();
    tier4controller.dispose();
    tier5controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).black,
        appBar: AppBar(
          leading: Material(
            elevation: 20,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: IconButton(
              color: Theme.of(context).white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                final shouldPop = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        'All your changes will be lost.',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
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
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );

                if (shouldPop == true && context.mounted) {
                  Navigator.of(context).pop();
                }
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
              child: TextButton(
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onPressed: () {
                  final editorProvider =
                      Provider.of<EditorProvider>(context, listen: false);
                  final tierlistsprovider =
                      Provider.of<TierListsProvider>(context, listen: false);
                  final tierList = editorProvider.tierList;
                  final isNew = editorProvider.isNewTierList;
                  if (isNew) {
                    tierlistsprovider.addUserTierList(tierList);
                  } else {
                    tierlistsprovider.updateTierList(tierList);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tier List saved',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      backgroundColor: Theme.of(context).primaryColorDark,
                    ),
                  );
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        body: TierListWidget(repaintBoundaryKey),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.text_fields,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: 'Add Text',
                  onPressed: () {
                    if (Provider.of<EditorProvider>(context, listen: false)
                        .hasReachedMaxItems()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You have reached the maximum number of items',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          backgroundColor: Theme.of(context).primaryColorDark,
                        ),
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
                                          height: 270,
                                          width: 240,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              border: Border.all(
                                                  width: 3,
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                        controller:
                                                            addtextcontroller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter text here",
                                                          hintStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      ZoomTapAnimation(
                                                        onTap: () {
                                                          final text =
                                                              addtextcontroller
                                                                  .text
                                                                  .trim();
                                                          if (text.isNotEmpty) {
                                                            final editorProvider =
                                                                Provider.of<
                                                                        EditorProvider>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            editorProvider
                                                                .addNewTextItem(
                                                                    text);

                                                            addtextcontroller
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                          child: Center(
                                                            child: Text(
                                                              "Save",
                                                              style: Theme.of(
                                                                      context)
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
                                              addtextcontroller.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: 'Add Image',
                  onPressed: () async {
                    if (Provider.of<EditorProvider>(context, listen: false)
                        .hasReachedMaxItems()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You have reached the maximum number of items',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          backgroundColor: Theme.of(context).primaryColorDark,
                        ),
                      );
                    } else {
                      var status = await Permission.photos.request();
                      if (status.isGranted || status.isLimited) {
                        var pickedImage = await Utils.pickImage();

                        if (pickedImage != null && context.mounted) {
                          File? savedImage = await Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return CropImageScreen(imageFile: pickedImage);
                          }));
                          if (savedImage != null && context.mounted) {
                            final editorProvider = Provider.of<EditorProvider>(
                                context,
                                listen: false);
                            editorProvider.addNewImageItem(savedImage);
                          }
                        }
                      } else {
                        openAppSettings();
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: 'Download',
                  onPressed: () async {
                    var status = await Permission.photos.request();
                    if (status.isGranted || status.isLimited) {
                      var img = await captureTierList();
                      if (img == null) {
                        return;
                      }
                      ImageGallerySaver.saveImage(img, quality: 100);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Tier List saved to gallery',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            backgroundColor: Theme.of(context).primaryColorDark,
                          ),
                        );
                      }
                    } else {
                      openAppSettings();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.dehaze,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: 'Modify Tiers',
                  onPressed: () {
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
                                        height: 550,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            border: Border.all(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColorLight),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Modify Tiers",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  Column(
                                                    children: [
                                                      TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            tier1controller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            tier2controller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            tier3controller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            tier4controller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller:
                                                            tier5controller,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                          ),
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      ZoomTapAnimation(
                                                        onTap: () {
                                                          final tier1text =
                                                              tier1controller
                                                                  .text
                                                                  .trim();
                                                          final tier2text =
                                                              tier2controller
                                                                  .text
                                                                  .trim();
                                                          final tier3text =
                                                              tier3controller
                                                                  .text
                                                                  .trim();
                                                          final tier4text =
                                                              tier4controller
                                                                  .text
                                                                  .trim();
                                                          final tier5text =
                                                              tier5controller
                                                                  .text
                                                                  .trim();
                                                          if (tier1text.isNotEmpty &&
                                                              tier2text
                                                                  .isNotEmpty &&
                                                              tier3text
                                                                  .isNotEmpty &&
                                                              tier4text
                                                                  .isNotEmpty &&
                                                              tier5text
                                                                  .isNotEmpty) {
                                                            final editorProvider =
                                                                Provider.of<
                                                                        EditorProvider>(
                                                                    context,
                                                                    listen:
                                                                        false);
                                                            editorProvider
                                                                .changeTiers([
                                                              tier1text,
                                                              tier2text,
                                                              tier3text,
                                                              tier4text,
                                                              tier5text,
                                                            ]);
                                                            tier1controller
                                                                    .text =
                                                                tier1text;
                                                            tier2controller
                                                                    .text =
                                                                tier2text;
                                                            tier3controller
                                                                    .text =
                                                                tier3text;
                                                            tier4controller
                                                                    .text =
                                                                tier4text;
                                                            tier5controller
                                                                    .text =
                                                                tier5text;
                                                            Navigator.pop(
                                                                context);
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                          child: Center(
                                                            child: Text(
                                                              "Save",
                                                              style: Theme.of(
                                                                      context)
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
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            final provider =
                                                Provider.of<EditorProvider>(
                                                    context,
                                                    listen: false);
                                            tier1controller.text = provider
                                                    .tierList.tiers[0].label ??
                                                "S";
                                            tier2controller.text = provider
                                                    .tierList.tiers[1].label ??
                                                "A";
                                            tier3controller.text = provider
                                                    .tierList.tiers[2].label ??
                                                "B";
                                            tier4controller.text = provider
                                                    .tierList.tiers[3].label ??
                                                "C";
                                            tier5controller.text = provider
                                                    .tierList.tiers[4].label ??
                                                "D";
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
