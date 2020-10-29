import 'package:flutter/material.dart';
import 'package:music_player_app/extensions/extensions.dart';
import 'package:music_player_app/music_player_page/widgets/SongInfoItem.dart';

/// [SongInfoWidget] builds song image , title, and card indicator UI
class SongInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildActivePageIndicatorWidget(context)),
        Expanded(flex: 3, child: _buildPageViewWidget()),
        Expanded(flex: 1, child: _buildSongTitleWidget(context)),
      ],
    );
  }

  /// builds swipable card UI
  Widget _buildPageViewWidget() {
    final controller = PageController(initialPage: 1, viewportFraction: 0.7);
    return IgnorePointer(
      ignoring: true,
      child: PageView(
        controller: controller,
        children: [
          SongInfoItemWidget(),
          SongInfoItemWidget(),
          SongInfoItemWidget(),
        ],
      ),
    );
  }

  /// builds Song title and Movie(sub) title
  Widget _buildSongTitleWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '01 - Saahore Baahubali',
          style: context.themeData.textTheme.headline1.copyWith(
              fontSize: context.widthOf(0.05), fontWeight: FontWeight.bold,color: context.themeData.primaryColor),
        ),
        Text(
          'Baahubali-2',
          style: context.themeData.textTheme.bodyText1
              .copyWith(fontSize: context.widthOf(0.03), color: context.themeData.primaryColor.withOpacity(0.7)),
        ),
      ],
    );
  }

  /// builds active page indicator for swipable card UI
  Widget _buildActivePageIndicatorWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black12,
          radius: context.widthOf(0.01),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: context.widthOf(0.01), left: context.widthOf(0.01)),
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            radius: context.widthOf(0.015),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.black12,
          radius: context.widthOf(0.01),
        ),
      ],
    );
  }
}
