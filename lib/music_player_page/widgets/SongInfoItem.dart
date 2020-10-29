import 'package:flutter/material.dart';
import 'package:music_player_app/extensions/extensions.dart';

/// [SongInfoItemWidget] card UI
class SongInfoItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.widthOf(0.1)),
        child: Image.asset(
          'assets/images/album.png',
          fit: BoxFit.fill,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(context.widthOf(0.1))),
      ),
    );
  }
}
