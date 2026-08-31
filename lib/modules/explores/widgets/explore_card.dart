import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class ExploreCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onBooking;
  final bool isFavorite;

  const ExploreCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onFavorite,
    this.onBooking,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ThemeConfig.spacingBase,
        vertical: ThemeConfig.spacingSM,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(ThemeConfig.spacingBase),
                  ),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 120,
                      height: 100,
                      color: ThemeConfig.colorGreyLight,
                      child: Icon(Icons.broken_image),
                    ),
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: GestureDetector(
                //     onTap: onFavorite,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         // color: Colors.white,
                //         shape: BoxShape.circle,
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black.withValues(alpha: 0.2),
                //             blurRadius: 4,
                //             offset: Offset(0, 2),
                //           ),
                //         ],
                //       ),
                //       padding: const EdgeInsets.all(10.0),
                //       child: Icon(
                //         LineIcons.heart,
                //         color: isFavorite
                //             ? Colors.red.withValues(alpha: 0.8)
                //             : Colors.blue,
                //         size: responsiveSize(
                //           context,
                //           ThemeConfig.iconSizeLarge,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            // Content section on right (no background)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(ThemeConfig.spacingSM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
