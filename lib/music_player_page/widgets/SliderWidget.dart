import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_app/extensions/extensions.dart';
import 'package:music_player_app/music_player_page/blocs/music_player_cubit.dart';

/// [SliderWidget] builds slider UI and Music Playing Time UI
class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  MusicPlayerCubit _cubit;

  int _mixValue = 0;
  int _maxValue = 0;
  int _currentValue = 0;

  bool _isChangeStarted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.widthOf(0.05), right: context.widthOf(0.05)),
      child: Column(
        children: [
          _buildSliderWidget(),
          _buildLeftRightTimerWidget(),
        ],
      ),
    );
  }

  /// builds Slider UI
  Widget _buildSliderWidget() {
    return Slider(
      min: _mixValue.toDouble(),
      max: _maxValue.toDouble(),
      value: _currentValue.toDouble(),
      onChangeStart: (_) {
        _isChangeStarted = true;
      },
      onChangeEnd: (val) {
        _isChangeStarted = false;
        _cubit.seek(Duration(milliseconds: val.toInt()));
      },
      onChanged: (val) {
        setState(() {
          _currentValue = val.toInt();
        });
      },
    );
  }

  /// builds Song current and max Timer UI
  Widget _buildLeftRightTimerWidget() {
    var textStyle = context.themeData.textTheme.bodyText1.copyWith(
        fontSize: context.widthOf(0.03), color: context.themeData.primaryColor);

    return Padding(
      padding: EdgeInsets.only(
          left: context.widthOf(0.05), right: context.widthOf(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${Duration(milliseconds: _currentValue).toReadableString()}',
            style: textStyle,
          ),
          Text(
            '${Duration(milliseconds: _maxValue).toReadableString()}',
            style: textStyle.copyWith(
              color: context.themeData.primaryColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = context.bloc<MusicPlayerCubit>();
    _cubit.registerCurrentDurationEvent(_onSongCurrentDuration);
    _cubit.registerMaxDurationEvent(_onSongMaxDuration);
  }

  void _onSongMaxDuration(int maxDuration) {
    setState(() {
      _maxValue = maxDuration;
    });
  }

  void _onSongCurrentDuration(int currentDuration) {
    if (_isChangeStarted) {
      return;
    }

    setState(() {
      _currentValue = currentDuration;
    });
  }

  /// releases resources and cancels subscriptions if any
  @override
  void dispose() {
    _cubit.registerCurrentDurationEvent(null);
    _cubit.registerMaxDurationEvent(null);
    super.dispose();
  }
}
