import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerWidget extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageViewerWidget({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewerWidget> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewerWidget> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            alignment: Alignment.center,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.imageUrls[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.95,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.imageUrls[index],
                  ),
                );
              },
              itemCount: widget.imageUrls.length,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                              (event.expectedTotalBytes ?? 1),
                  ),
                ),
              ),
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              pageController: pageController,
              onPageChanged: (index) {},
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (pageController.hasClients) {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (pageController.hasClients) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 20,
          child: SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  LineIcons.timesCircle,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
