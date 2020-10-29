import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/music_player_page/blocs/music_player_cubit.dart';
import 'package:music_player_app/music_player_page/widgets/controls_widget.dart';
import 'package:music_player_app/music_player_page/widgets/song_info_widget.dart';

/// Music player Page UI
class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MusicPlayerCubit>(
      create: (context) => MusicPlayerCubit(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(flex: 4, child: SongInfoWidget()),
            Expanded(flex: 3, child: ControlsWidget()),
          ],
        ),
      ),
    );
  }

}
