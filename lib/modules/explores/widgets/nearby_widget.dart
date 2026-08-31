import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/core/widgets/header/highlight_header.dart';

import '/../modules/explores/models/content_image.dart';
import '/../modules/explores/pages/explore_list_page.dart';
import '/../modules/explores/widgets/card_slider_widget.dart';

class NearbyWidget extends StatelessWidget {
  const NearbyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildFeaturedContent(context, _mockFeaturedData());
    // return BlocBuilder<FeaturedBloc, FeaturedState>(
    //   builder: (context, state) {
    //     if (state is FeaturedLoading) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else if (state is FeaturedLoaded) {
    //       return _buildFeaturedContent(
    //         context,
    //         state.featured.featuredFirst.contentImage,
    //       );
    //     } else if (state is FeaturedError) {
    //       return Center(child: Text('Error: ${state.message}'));
    //     }
    //     return SizedBox.shrink();
    //   },
    // );
  }

  Widget _buildFeaturedContent(
    BuildContext context,
    List<ContentImage> featured,
  ) {
    return Column(
      children: <Widget>[
        HighlightHeader(
          title: 'explore.nearby'.tr(),
          onTap: () {
            nextScreen(context, ExploreListPage());
          },
        ),
        SizedBox(height: ThemeConfig.spacingMD),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.only(
              left: ThemeConfig.spacingBase,
              right: ThemeConfig.spacingMD,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            itemBuilder: (context, index) {
              return CardSliderWidget(
                contentImage: featured[index],
                onTap: () {
                  // nextScreen(
                  //   context,
                  //   PlaceDetailPage(placeId: featured[index].id),
                  // );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<ContentImage> _mockFeaturedData() {
    return [
      ContentImage(
        id: '6a33ca2c9b4030a76aa9f4c2',
        slug: 'featured-1',
        name: 'Amazing Place Amazing',
        summary: 'Discover this beautiful location',
        imageCover:
            'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&h=300&fit=crop',
      ),
      ContentImage(
        id: '6a33ca2c9b4030a76aa9f4c2',
        slug: 'featured-2',
        name: 'Hidden Gem',
        summary: 'A secret spot worth visiting',
        imageCover:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=300&fit=crop',
      ),
      ContentImage(
        id: '6a33ca2c9b4030a76aa9f4c2',
        slug: 'featured-3',
        name: 'Nature Paradise',
        summary: 'Experience the beauty of nature',
        imageCover:
            'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400&h=300&fit=crop',
      ),
      ContentImage(
        id: '6a33ca2c9b4030a76aa9f4c2',
        slug: 'featured-4',
        name: 'Urban Adventure',
        summary: 'Explore the city like never before',
        imageCover:
            'https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?w=400&h=300&fit=crop',
      ),
    ];
  }
}
