import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/services/private_image.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:template_app_flutter/core/widgets/loading/loading_widget.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../repositories/profile_image_repository.dart';

class ProfileImageEditPage extends StatefulWidget {
  final File? initialImage;

  const ProfileImageEditPage({super.key, this.initialImage});

  @override
  State<ProfileImageEditPage> createState() => _ProfileImageEditPageState();
}

class _ProfileImageEditPageState extends State<ProfileImageEditPage> {
  static const double _cropHorizontalInset = ThemeConfig.spacingXS;
  static const double _cropVerticalInset = ThemeConfig.spacingXXL;
  static const double _minCropPreviewSize = 150;
  static const double _maxCropPreviewSize = 400;
  static const int _cropSize = 300;
  static const double _maxScaleFactor = 10;

  final TransformationController _transformationController =
      TransformationController();
  ui.Image? _decodedImage;
  Size _viewportSize = Size.zero;
  double _baseScale = 1;
  double _currentScale = 1;
  Offset _offset = Offset.zero;
  bool _isSaving = false;
  bool _isLoadingImage = false;

  double get _cropPreviewSize {
    if (_viewportSize == Size.zero) {
      return _maxCropPreviewSize;
    }

    final availableWidth = _viewportSize.width - (_cropHorizontalInset * 2);
    final availableHeight = _viewportSize.height - (_cropVerticalInset * 2);
    final computed = availableWidth < availableHeight
        ? availableWidth
        : availableHeight;
    return computed.clamp(_minCropPreviewSize, _maxCropPreviewSize).toDouble();
  }

  @override
  void initState() {
    super.initState();
    _loadInitialImage();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialImage() async {
    final imageFile = widget.initialImage;
    if (imageFile == null) {
      return;
    }

    setState(() {
      _isLoadingImage = true;
    });

    try {
      final bytes = await imageFile.readAsBytes();
      final decoded = await _decodeUiImage(bytes);
      if (!mounted || decoded == null) {
        return;
      }

      _decodedImage = decoded;
      setState(() {});
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }
  }

  Future<ui.Image?> _decodeUiImage(Uint8List bytes) async {
    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      return frame.image;
    } catch (_) {
      return null;
    }
  }

  void _initializeTransform() {
    final decoded = _decodedImage;
    if (decoded == null || _viewportSize == Size.zero) {
      return;
    }

    final cropRect = _cropRect;
    final imageWidth = decoded.width.toDouble();
    final imageHeight = decoded.height.toDouble();

    _baseScale =
        (_cropPreviewSize / imageWidth) > (_cropPreviewSize / imageHeight)
        ? (_cropPreviewSize / imageWidth)
        : (_cropPreviewSize / imageHeight);
    _currentScale = _baseScale;
    _offset = Offset(
      cropRect.left + (cropRect.width - (imageWidth * _currentScale)) / 2,
      cropRect.top + (cropRect.height - (imageHeight * _currentScale)) / 2,
    );
    _applyTransform(_currentScale, _offset);
  }

  Rect get _cropRect => Rect.fromCenter(
    center: _viewportSize.center(Offset.zero),
    width: _cropPreviewSize,
    height: _cropPreviewSize,
  );

  void _syncViewportSize(Size size) {
    if (_viewportSize == size) {
      return;
    }
    _viewportSize = size;
    _initializeTransform();
  }

  void _applyTransform(double scale, Offset offset) {
    _currentScale = scale;
    _offset = offset;
    _transformationController.value = Matrix4.identity()
      ..translateByDouble(offset.dx, offset.dy, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1);
  }

  void _syncTransformFromViewer() {
    final matrix = _transformationController.value;
    final scale = matrix.storage[0];
    final dx = matrix.storage[12];
    final dy = matrix.storage[13];

    _currentScale = scale;
    _offset = Offset(dx, dy);
  }

  void _clampTransformRealtime() {
    _syncTransformFromViewer();

    final clampedScale = _currentScale.clamp(
      _baseScale,
      _baseScale * _maxScaleFactor,
    );
    final clampedOffset = _clampOffset(_offset, clampedScale);

    const tolerance = 0.01;
    final changed =
        (_currentScale - clampedScale).abs() > tolerance ||
        (_offset.dx - clampedOffset.dx).abs() > tolerance ||
        (_offset.dy - clampedOffset.dy).abs() > tolerance;

    if (changed) {
      _applyTransform(clampedScale, clampedOffset);
    } else {
      _currentScale = clampedScale;
      _offset = clampedOffset;
    }
  }

  void _clampAfterInteraction() {
    _syncTransformFromViewer();
    final clampedScale = _currentScale.clamp(
      _baseScale,
      _baseScale * _maxScaleFactor,
    );
    final clampedOffset = _clampOffset(_offset, clampedScale);

    const tolerance = 0.01;
    final changed =
        (_currentScale - clampedScale).abs() > tolerance ||
        (_offset.dx - clampedOffset.dx).abs() > tolerance ||
        (_offset.dy - clampedOffset.dy).abs() > tolerance;

    if (changed) {
      setState(() {
        _applyTransform(clampedScale, clampedOffset);
      });
    }
  }

  Offset _clampOffset(Offset offset, double scale) {
    final decoded = _decodedImage;
    if (decoded == null) {
      return offset;
    }

    final cropRect = _cropRect;
    final scaledWidth = decoded.width * scale;
    final scaledHeight = decoded.height * scale;

    final minX = cropRect.right - scaledWidth;
    final maxX = cropRect.left;
    final minY = cropRect.bottom - scaledHeight;
    final maxY = cropRect.top;

    return Offset(
      minX > maxX
          ? cropRect.left + (cropRect.width - scaledWidth) / 2
          : offset.dx.clamp(minX, maxX),
      minY > maxY
          ? cropRect.top + (cropRect.height - scaledHeight) / 2
          : offset.dy.clamp(minY, maxY),
    );
  }

  Future<void> _saveCroppedImage() async {
    final decoded = _decodedImage;
    if (decoded == null || _isSaving) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final cropRect = _cropRect;

      final double srcX = ((cropRect.left - _offset.dx) / _currentScale)
          .clamp(0, decoded.width.toDouble() - 1)
          .toDouble();
      final double srcY = ((cropRect.top - _offset.dy) / _currentScale)
          .clamp(0, decoded.height.toDouble() - 1)
          .toDouble();
      final double srcW = (cropRect.width / _currentScale)
          .clamp(1, decoded.width.toDouble() - srcX)
          .toDouble();
      final double srcH = (cropRect.height / _currentScale)
          .clamp(1, decoded.height.toDouble() - srcY)
          .toDouble();

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final cropPreviewSize = _cropPreviewSize;
      canvas.drawImageRect(
        decoded,
        Rect.fromLTWH(srcX, srcY, srcW, srcH),
        Rect.fromLTWH(0, 0, cropPreviewSize, cropPreviewSize),
        Paint(),
      );

      final picture = recorder.endRecording();
      final outputImage = await picture.toImage(
        cropPreviewSize.toInt(),
        cropPreviewSize.toInt(),
      );
      final byteData = await outputImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) {
        if (mounted) {
          Navigator.of(context).pop();
        }
        return;
      }

      // Enforce a strict 300x300 file output after crop.
      final decodedOutput = img.decodeImage(byteData.buffer.asUint8List());
      if (decodedOutput == null) {
        if (mounted) {
          Navigator.of(context).pop();
        }
        return;
      }

      final resizedOutput = img.copyResize(
        decodedOutput,
        width: _cropSize,
        height: _cropSize,
        interpolation: img.Interpolation.cubic,
      );

      final tempDir = await getTemporaryDirectory();
      final outputFile = File(
        '${tempDir.path}/avatar_crop_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await outputFile.writeAsBytes(img.encodeJpg(resizedOutput));

      final isUploaded = await _uploadCroppedImage(outputFile);
      if (mounted && isUploaded) {
        Navigator.of(context).pop(outputFile);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<bool> _uploadCroppedImage(File croppedImage) async {
    try {
      final repo = ProfileImageRepository(
        privateImage: PrivateImage(context: context),
      );

      await repo.uploadProfileImage(
        filePath: croppedImage.path,
        fileName: croppedImage.uri.pathSegments.last,
        profileId: '',
      );

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Upload success');
      }
      return true;
    } catch (_) {
      if (mounted) {
        SnackBarUtils.showError(context, 'error.network');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'profile.profile_image_edit.title'.tr(),
        showBackButton: false,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final decoded = _decodedImage;

    return SafeArea(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final editorWidth = constraints.maxWidth
                  .clamp(220.0, 500.0)
                  .toDouble();
              final targetEditorHeight =
                  editorWidth +
                  ((_cropVerticalInset - _cropHorizontalInset) * 2);
              final editorHeight = targetEditorHeight
                  .clamp(220.0, constraints.maxHeight)
                  .toDouble();

              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: editorWidth,
                  height: editorHeight,
                  child: _isLoadingImage
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : widget.initialImage == null || decoded == null
                      ? Center(
                          child: Text(
                            'profile.profile_image_edit.no_image_selected'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            _syncViewportSize(constraints.biggest);

                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRect(
                                    child: InteractiveViewer(
                                      transformationController:
                                          _transformationController,
                                      panEnabled: true,
                                      scaleEnabled: true,
                                      constrained: false,
                                      minScale: _baseScale,
                                      maxScale: _baseScale * _maxScaleFactor,
                                      onInteractionUpdate: (_) {
                                        _clampTransformRealtime();
                                      },
                                      onInteractionEnd: (_) {
                                        _clampAfterInteraction();
                                      },
                                      child: SizedBox(
                                        width: decoded.width.toDouble(),
                                        height: decoded.height.toDouble(),
                                        child: RawImage(image: decoded),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: IgnorePointer(
                                    child: CustomPaint(
                                      painter: _CircleOverlayPainter(
                                        holeRadius: _cropPreviewSize / 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              );
            },
          ),

          const SizedBox(height: ThemeConfig.spacingBase),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('common.cancel'.tr()),
              ),
              const SizedBox(width: ThemeConfig.spacingBase),
              ElevatedButton(
                onPressed: _isSaving ? null : _saveCroppedImage,
                child: _isSaving ? LoadingWidget() : Text('common.save'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleOverlayPainter extends CustomPainter {
  final double holeRadius;

  _CircleOverlayPainter({required this.holeRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final fullRect = Offset.zero & size;
    final overlayPath = Path()..addRect(fullRect);
    final holePath = Path()
      ..addOval(
        Rect.fromCircle(center: size.center(Offset.zero), radius: holeRadius),
      );
    final combined = Path.combine(
      PathOperation.difference,
      overlayPath,
      holePath,
    );

    canvas.drawPath(
      combined,
      Paint()..color = Colors.black.withValues(alpha: 0.5),
    );
  }

  @override
  bool shouldRepaint(covariant _CircleOverlayPainter oldDelegate) =>
      oldDelegate.holeRadius != holeRadius;
}
