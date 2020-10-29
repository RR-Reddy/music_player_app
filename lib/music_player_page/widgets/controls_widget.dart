import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/extensions/extensions.dart';
import 'package:music_player_app/music_player_page/blocs/music_player_cubit.dart';
import 'package:music_player_app/music_player_page/enum/music_player_event.dart';
import 'package:music_player_app/music_player_page/widgets/SliderWidget.dart';

/// [ControlsWidget] builds  music player play/pause, fast forward, fast rewind and slider UI
class ControlsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(flex: 1, child: _buildPlayControlsWidget(context)),
          Expanded(flex: 1, child: SliderWidget()),
        ],
      ),
    );
  }

  /// builds  play/pause, fast forward and fast rewind UI
  Widget _buildPlayControlsWidget(BuildContext context) {
    return Stack(
      children: [
        _buildPlayPauseWidget(context),
        _buildFastRewindWidget(context),
        _buildFastForwardWidget(context),
      ],
    );
  }

  Widget _buildPlayPauseWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundColor: context.themeData.primaryColor,
        radius: context.widthOf(0.09),
        child: IconButton(
            color: Colors.white,
            icon: BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
                builder: (context, state) {
              var iconData = state.event == MusicPlayerEvent.EVENT_PLAYING
                  ? Icons.pause
                  : Icons.play_arrow;
              return Icon(iconData);
            }),
            iconSize: context.widthOf(0.12),
            onPressed: () {
              context.bloc<MusicPlayerCubit>().playOrPause();
            }),
      ),
    );
  }

  Widget _buildFastRewindWidget(BuildContext context) {
    return Align(
      alignment: Alignment(-0.5, 0),
      child: CircleAvatar(
        backgroundColor: context.themeData.primaryColor,
        radius: context.widthOf(0.06),
        child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.fast_rewind),
            iconSize: context.widthOf(0.07),
            onPressed: () {}),
      ),
    );
  }

  Widget _buildFastForwardWidget(BuildContext context) {
    return Align(
      alignment: Alignment(0.5, 0),
      child: CircleAvatar(
        backgroundColor: context.themeData.primaryColor,
        radius: context.widthOf(0.06),
        child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.fast_forward),
            iconSize: context.widthOf(0.07),
            onPressed: () {}),
      ),
    );
  }
}
