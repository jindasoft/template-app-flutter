import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/modules/explores/widgets/nearby_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildContent();
  }

  Future _onRefresh() async {
    // context.read<FeaturedBloc>().onRefresh();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildContent() {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _onRefresh(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: ThemeConfig.spacingMD),
              child: Column(children: [NearbyWidget()]),
            ),
          ),
        ),
      ),
    );
  }
}
