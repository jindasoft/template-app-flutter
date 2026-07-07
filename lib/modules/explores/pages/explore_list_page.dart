import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/modules/explores/widgets/explore_card.dart';

class ExploreListPage extends StatefulWidget {
  const ExploreListPage({super.key});

  @override
  State<ExploreListPage> createState() => _ExploreListPageState();
}

class _ExploreListPageState extends State<ExploreListPage> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  final Set<int> _favorites = {};

  final List<Map<String, String>> _exploreList = [
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Sunrise Badminton Club',
      'subtitle': 'แบดมินตัน • 4 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Professional Court Center',
      'subtitle': 'แบดมินตัน • 6 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Elite Sports Complex',
      'subtitle': 'แบดมินตัน • 8 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      'title': 'Community Sports Hall',
      'subtitle': 'แบดมินตัน • 3 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      'title': 'Downtown Badminton',
      'subtitle': 'แบดมินตัน • 5 คอร์ท',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // ถ้า scroll ใกล้ปลายสุด 500px
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      if (!_isLoading) {
        _loadMore();
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Mock API delay
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      // Add more mock data
      for (int i = 0; i < 5; i++) {
        _exploreList.add({
          'image':
              'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
          'title': 'Place ${_exploreList.length + 1}',
          'subtitle': 'แบดมินตัน • ${(i % 8) + 3} คอร์ท',
        });
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(centerTitle: false, title: Text('Nearby'));
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _exploreList.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at the end
        if (index == _exploreList.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConfig.spacingMD),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final item = _exploreList[index];
        return ExploreCard(
          image: item['image']!,
          title: item['title']!,
          subtitle: item['subtitle']!,
          isFavorite: _favorites.contains(index),
          onTap: () {
            // nextScreen(context, PlaceDetailPage(placeId: 'place_${index + 1}'));
          },
          onFavorite: () {
            setState(() {
              if (_favorites.contains(index)) {
                _favorites.remove(index);
              } else {
                _favorites.add(index);
              }
            });
          },
          onBooking: () {
            // TODO: Navigate to booking page
          },
        );
      },
    );
  }
}
