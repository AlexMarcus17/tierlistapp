import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tierlist/app/utils/utils.dart';

class CropImageScreen extends StatefulWidget {
  final XFile imageFile;

  const CropImageScreen({Key? key, required this.imageFile}) : super(key: key);

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  late CropController _cropController;
  Uint8List? _imageData;
  Uint8List? _croppedImageData;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _cropController = CropController();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final byteData = await widget.imageFile.readAsBytes();
    setState(() {
      _imageData = byteData;
    });
  }

  Future<void> saveCroppedImage(context) async {
    _cropController.crop();
    while (_croppedImageData == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (_croppedImageData != null) {
      final savedImage = await Utils.saveImagePermanently(
          _croppedImageData!, widget.imageFile.path);
      Navigator.of(context).pop(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _imageData == null || isloading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: Crop(
                      aspectRatio: 1.0,
                      controller: _cropController,
                      image: _imageData!,
                      onCropped: (croppedImage) {
                        _croppedImageData = croppedImage;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          child: const Text("Cancel"),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isloading = true;
                            });
                            saveCroppedImage(context);
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
