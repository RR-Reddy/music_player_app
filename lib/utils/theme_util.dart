import 'package:flutter/material.dart';
import 'package:music_player_app/constants/constants_colors.dart';

class ThemeUtil {
  /// custom theme data
  static final ThemeData themeData = _buildThemeData();

  static _buildThemeData() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: ConstantsColor.PRIMARY_COLOR,
      sliderTheme: _buildSliderTheme(base),
    );
  }

  static SliderThemeData _buildSliderTheme(ThemeData base) {
    return base.sliderTheme.copyWith(
      activeTickMarkColor: ConstantsColor.PRIMARY_COLOR,
      activeTrackColor: ConstantsColor.PRIMARY_COLOR,
      inactiveTickMarkColor: ConstantsColor.PRIMARY_COLOR.withOpacity(0.5),
      inactiveTrackColor: ConstantsColor.PRIMARY_COLOR.withOpacity(0.5),
      thumbColor: ConstantsColor.PRIMARY_COLOR,
    );
  }
}
