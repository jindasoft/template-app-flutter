import 'dart:io';
import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../widgets/images/image_viewer_widget.dart';

/// Fix image orientation and compress before upload
/// Returns corrected image path or original path if error occurs
Future<String> fixImageOrientation(String imagePath) async {
  final logger = AppLogger.instance;
  try {
    // Read image file
    final imageFile = File(imagePath);
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      logger.w('Could not decode image, returning original path');
      return imagePath;
    }

    // Resize image if too large
    final maxSize = AppConfig.imageDimensionWidth;
    img.Image resizedImage = image;
    if (image.width > maxSize || image.height > maxSize) {
      final aspectRatio = image.width / image.height;
      int newWidth = maxSize;
      int newHeight = (maxSize / aspectRatio).toInt();

      if (newHeight > maxSize) {
        newHeight = maxSize;
        newWidth = (maxSize * aspectRatio).toInt();
      }

      resizedImage = img.copyResize(image, width: newWidth, height: newHeight);
    }

    // Save corrected & compressed image to temp directory
    final tempDir = await getTemporaryDirectory();
    final correctedImagePath =
        '${tempDir.path}/corrected_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Encode with quality from config
    final correctedFile = File(correctedImagePath);
    await correctedFile.writeAsBytes(
      img.encodeJpg(resizedImage, quality: AppConfig.imageQuality),
    );

    return correctedImagePath;
  } catch (e) {
    logger.w('Error fixing image orientation: $e, using original image');
    return imagePath;
  }
}

/// Create FormData for image upload with automatic orientation fix
Future<FormData> createFormData(
  String filePath,
  String fileName, {
  Map<String, dynamic>? additionalFields,
}) async {
  final correctedFilePath = await fixImageOrientation(filePath);

  return FormData.fromMap({
    'file': await MultipartFile.fromFile(correctedFilePath, filename: fileName),
    ...?additionalFields,
  });
}

Future<void> showImageViewer(
  BuildContext context,
  List<String> imageUrls,
  int initialIndex,
) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  if (!context.mounted) return;
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ImageViewerWidget(imageUrls: imageUrls, initialIndex: initialIndex),
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
