import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tierlist/presentation/providers/tier_lists_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class Utils {
  static Future<XFile?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return null;

      return pickedFile;
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteAllImageFiles() async {
    final Directory appDir = await getApplicationDocumentsDirectory();

    final List<FileSystemEntity> files = appDir.listSync();

    for (var file in files) {
      if (file is File) {
        await file.delete();
      }
    }
  }

  static Future<File> saveImagePermanently(
      Uint8List uint8list, String path) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = basename(path);
    final String savedImagePath = '${appDir.path}/$fileName';
    final File savedImage = File(savedImagePath);
    await savedImage.writeAsBytes(uint8list);
    return savedImage;
  }

  static void showSettings(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                    height: 390,
                    width: 240,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                            width: 3,
                            color: Theme.of(context).primaryColorLight),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: StatefulBuilder(builder: (context, setState) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Settings",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Column(
                                children: [
                                  ZoomTapAnimation(
                                    onTap: () async {
                                      bool? shouldReset = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Confirm Reset'),
                                          content: const Text(
                                              'Are you sure you want to reset the app? This will delete all your tier lists.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text('Delete',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (shouldReset == true) {
                                        if (context.mounted) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Scaffold(
                                                body: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                          );
                                          await Provider.of<TierListsProvider>(
                                                  context,
                                                  listen: false)
                                              .resetUserTierLists();
                                          await deleteAllImageFiles();
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'App reset successfully'),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: Center(
                                        child: Text(
                                          "🔄 Reset",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 2,
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () async {
                                      final Uri emailUri = Uri(
                                        scheme: 'mailto',
                                        path: 'alexmarcus5040717@gmail.com',
                                      );

                                      if (await canLaunchUrl(emailUri)) {
                                        await launchUrl(emailUri,
                                            mode:
                                                LaunchMode.externalApplication);
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: Center(
                                        child: Text(
                                          "📝 Give Feedback",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 2,
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () async {
                                      final String iosUrl =
                                          'https://apps.apple.com/app/id<APP_ID>?action=write-review';
                                      final String androidUrl =
                                          'market://details?id=<PACKAGE_NAME>';

                                      final Uri rateUri = Uri.parse(
                                        Theme.of(context).platform ==
                                                TargetPlatform.iOS
                                            ? iosUrl
                                            : androidUrl,
                                      );

                                      if (await canLaunchUrl(rateUri)) {
                                        await launchUrl(rateUri);
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: Center(
                                        child: Text(
                                          "⭐️ Rate Us",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 2,
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () async {
                                      launchUrl(
                                        Uri.parse('https://flutter.dev'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: Center(
                                        child: Text(
                                          "🔒 Privacy Policy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Theme.of(context).primaryColorLight,
                                    thickness: 2,
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () {
                                      final String iosLink =
                                          'https://apps.apple.com/app/id<APP_ID>';
                                      final String androidLink =
                                          'https://play.google.com/store/apps/details?id=<PACKAGE_NAME>';

                                      final String appLink =
                                          Theme.of(context).platform ==
                                                  TargetPlatform.iOS
                                              ? iosLink
                                              : androidLink;

                                      Share.share(appLink);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      child: Center(
                                        child: Text(
                                          "📤 Share",
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
                      );
                    }),
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
                          child: Image.asset("assets/images/close.png"),
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
}
